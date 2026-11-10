# real-sfx's scripts: what Sound engineering uses

The scripts in `<skill>/real-sfx/scripts/` come from [real-sfx](https://github.com/Clipwing/skills/tree/main/skills/real-sfx) by Alexander Korbanov at Clipwing (MIT, `real-sfx/LICENSE`). `sound-stage.md`, Sound engineering, is the order of work; this file is the detail it points to: event kinds, unknown kinds, typing, searching the library, the settings a planned sound can carry, and what the scripts print. `<real-sfx>` below is `<skill>/real-sfx`. Run `. ~/.config/real-sfx/env.sh` first in every shell (Sound engineering, set-up).

## Contents

- Event kinds
- A kind real-sfx doesn't know
- Typing
- What `from_cues.py` prints
- Finding a recording in the library
- Settings a planned sound can carry
- Levels
- Where a sound lands, and what `verify.py` checks
- Editing the cue sheet
- Library set-up
- Scripts this skill doesn't use

## Event kinds

The sound plan's `type` is one of these kinds or a word in brackets after it. With `--ui library` every kind takes a real recording from the user's library, in the role shown.

| Kind (other words for it) | What it gets |
|---|---|
| `click` (press, tap, button, select) | `click`: single clicks first, then the first click of a double-click recording |
| `pop` (bubble, blip, appear) | `pop` (mouth pops only when the search names them) |
| `tick`, `tock` | `click`, then short water drops |
| `chime` (bell, ding, notify) | `chime` (bell, ring) |
| `success` (ok, done, complete) | `chime` with the Ding tag |
| `key` (keystroke, type, typing) | pieces of real typing recordings (Typing, below) |
| `whoosh` (swoosh, swipe, slide, move, zoom, push, pan) | `whoosh`, its length from `len` |
| `wipe` (transition, scene, cut) | a 0.7 s `whoosh`, 4 dB quieter |
| `hit` (impact, slam, stamp, stinger, boom) | `hit` with a sharp attack |
| `thump` (kick, bass_hit) | clean single foley hits (body, floor, wood), then a dark `hit` |
| `riser` (build, swell, tension), `drop` (sub_drop) | `riser` of length `len` starting at `t`; `sub_drop` or a dark `hit` |
| `glass` (crystal) / `shatter` (smash, break) | a ringing glass ping / breaking glass |
| `magic` (sparkle, shimmer, glow, reveal) | `chime` with the word magic: sparkles, music box, harp |
| `water` (drip, splash, droplet), `coins` (cash, money, purchase) | `water` drops of 0.1-0.7 s; `coin` |
| `glitch`, `error`, `camera`, `paper`, `data`, `ambience` | the role of the same name |

`sound_handoff.py events` reads the current list from `from_cues.py` itself and flags (exit 2) a `type` that isn't on it.

## A kind real-sfx doesn't know

An unknown kind stays quiet and is listed as "NOT mapped". Say what it is on the `from_cues.py` command line, then run `sound_handoff.py pins` and `sheet.py apply` again:

```
--kind beep=chime                            the plan's word = a kind real-sfx knows
--kind beep=role:chime,max_dur=0.4           a role with limits
--kind key=slices:740,763                    single sounds cut from these recordings (ids from search.py), in turn
--one-source thump,pop                       one physical object (a ball, steps): one family of recordings, takes in turn
```

Never use `--remember`: it writes into `<real-sfx>/`, which the next plugin update replaces. Write the `--kind` into the build log so the next run uses it too.

## Typing

A `key` moment with `len` (seconds) and `n` (characters) becomes separate real keystrokes, each 40-85 ms, one keyboard for the whole film, at most 14 a second (`thinned: key N` when the run was faster). A run of 8 or more `click` moments 35-170 ms apart is taken as typing too (`--no-typing-detect` keeps them as clicks). With no typing recordings in the library the keys stay quiet and the output says so. A typing run can't name one recording in the plan; give it its keyboard with `--kind key=slices:<ids>` instead.

## What `from_cues.py` prints

Read these lines every run and act on them before step 4:

- `routes: click -> library:click ...`: where each kind went. Every kind should say `library`.
- `NOT mapped` and `declared N events: M voiced, K silent`: kinds left quiet (above).
- `WARN sync: the list is consistently ±X s from the picture`: the plan's times are offset. Fix the plan's times (the plan is final film time), don't use `--shift`.
- `VERDICT: the cue list and this render come from different cuts`: the plan or the render is out of date. Retime the plan (`build-and-qa.md`, Retiming) or use the render it was written for.
- Strong picture changes with no sound (from `--moments`): a check for missed sounds, never a list to fill (Sound engineering, step 3).
- `fused: N` (moments of one kind closer than 25 ms became one sound) and `thinned: kind N`.

Running `from_cues.py` again rebuilds the cue sheet from scratch, so `pins` and `sheet.py apply` always follow it.

## Finding a recording in the library

```
python3 <real-sfx>/scripts/search.py --query "trackpad|mouse" --role click --paths     # name or folder; a|b = either
python3 <real-sfx>/scripts/search.py --role chime --says "ding|bell" --max-dur 1.2 --sheet build/audio/sfx/chimes.png
python3 <real-sfx>/scripts/search.py --role whoosh --like 412 --target-dur 0.7          # like recording 412, near 0.7 s
python3 <real-sfx>/scripts/listen.py onsets <file>                                        # the separate sounds inside one recording
```

- `--query` matches the file and folder name; `--says` matches plain words for the sound and its tags; `--paths` prints each file's path, tags and source recording.
- `--sheet` draws each candidate's waveform and spectrogram with its id. Choose by what moves and what it hits: paper is paper, a bead on a string is a plastic click.
- A length with `*` (`0.36*`) is the audible part; the rest of the file is silence.
- Library names can be wrong (a pack's "Game Select" is tagged as an animal). Check the tags with `--paths` before taking a sound.
- Write the chosen recording into the plan as `file` (its full path), not the search id: ids change when the index is rebuilt.

## Settings a planned sound can carry

`sound_handoff.py` passes these from the plan to the cue sheet unchanged:

| Field | What it does |
|---|---|
| `role` | the role that sets the level and which point lands on the frame; a named `file` otherwise takes its kind's role |
| `slice` | the part of the recording to use: `[start, length]` in seconds, `"first"` (its first clear sound: a mouse recording holds press and release), `"loudest"`, or `{"onset": k}` |
| `gain_db` | dB above or below the role's level (below) |
| `pitch` | semitones, -12 to 12, length kept. A named recording plays at its own pitch unless the plan gives one |
| `anchor` | which point of the sound lands on `t`: `start`, `arrive`, `peak` or `end` (Where a sound lands, below) |
| `fade_in`, `fade_out`, `max_dur` | seconds; `max_dur` cuts the sound with a short fade |
| `lowpass`, `highpass` | cut-off in Hz: tame a harsh sound, thin a boomy one |
| `pan` | -1 (left) to 1 (right), for a sound that follows something across the picture |
| `mono` | `true` plays the louder channel on both sides. `mix.py` does this by itself for a stereo recording whose channels cancel when summed (it would vanish on a phone speaker) and prints `mono:` |

## Levels

Each role is brought to a peak level (hit -4, whoosh -9, riser -12, chime -13, click, pop and typing -14, ambience -24 dBFS), and sounds of one role to the same loudness. `gain_db` moves one sound from there: small sounds are `0` to `-4`, since the roles are already quiet. `--no-loudnorm` keeps these levels; the film's loudness and the effects stem's gain are set in the mix (Sound engineering, step 8).

- A thin bright sound can be raised by up to 6 dB to match its role. Its peak may then be the highest on the track. Lower that sound, not the others.
- Lowering a sound that already sits at the ceiling changes it by about half what you write. Read the `gain` column of `mix.py --plan` and `peak_after_db` in the resolved cues, not the number in the plan.
- `mix.py` warnings to act on: `capped` (a quiet recording that couldn't be raised enough), a slice raised by more than 12 dB, a cue peaking above 0 dBFS before the limiter, and `WARN slice ... holds two hits`.

## Where a sound lands, and what `verify.py` checks

Clicks, pops and other short sounds land on `t` by their start. Hits, whooshes, chimes and other sounds placed by their peak are placed by their arrival when they get loud fast (the first 60 ms within 6 dB of their loudest), and by their peak when they build to a climax, such as a riser. A quiet lead-in before a sound is skipped. Set `anchor` in the plan only when the user hears a sound early or late.

`verify.py` measures where each judged sound lands on the track and exits 1 when one is off by more than 40 ms (whooshes, risers and long textures get a wider margin) or the track clips. `MISSING` means the render lost a sound: render again. Its `mono:` line says how many dB the track loses on a phone speaker (0 is equal channels; 6 or more means something cancels). To look closely at one moment: `python3 <real-sfx>/scripts/zoom.py <resolved> <track> --at <seconds> --span 3 --video <render>` draws the frames, each cue and the waveform in one picture.

## Editing the cue sheet

For a quick try before the user listens (the plan keeps anything approved, and the next run of step 2 rebuilds the sheet from it):

```
python3 <real-sfx>/scripts/sheet.py show build/audio/sfx/cues.json
python3 <real-sfx>/scripts/sheet.py set build/audio/sfx/cues.json --at 7.25 gain_db=-3 file=<path>
python3 <real-sfx>/scripts/sheet.py drop build/audio/sfx/cues.json --at 7.25
```

`--at` names a cue by its time; add `--label` when two cues share it. `set` replaces the automatic pick with `file=`, and `--unset <field>` removes a setting. A cue keeps the label of its kind ("whoosh x0.25") when its recording changes by hand, so set `label=` too, or reports name the wrong moment.

## Library set-up

- `setup.py scan <folder>`: which folders look like sound libraries.
- `setup.py add-library <name> <folder> --index`: add another library (`--tier extra` for a fallback library, used only when the main one has fewer than three fitting sounds).
- `build_index.py`: rebuild the index after adding files or moving the library.
- uisfx, the interface pack in `<real-sfx>/vendor/`, is CC0 and made by synthesis. It is used only when the user has agreed (`sound-stage.md`, What this skill changes).

## Scripts this skill doesn't use

Leave these unless the user asks for them: `texture.py` and `bed.py` (extra small sounds and a background bed), `critique.py`, `levels.py`, `review.py` and `listen_page.py` (scores and listening pages; extra evidence at most, never the verdict), the taste and listening tests (`taste_test.py`, `adjust_test.py`, `moment_test.py`, `taste.py`), `find_moments.py`, `suggest_cues.py`, `ui_events.py`, `from_synth.py` and `unbake.py` (finding moments when there is no plan), `beats.py` (`fit_music.py` fits the music here), `hear.py` and `listen.py install` (model downloads into `<real-sfx>/vendor/`), and `learn_style.py` (writes into `<real-sfx>/`).
