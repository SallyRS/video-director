# Where real-sfx's scripts come from

This folder holds the scripts of real-sfx by Alexander Korbanov at Clipwing (MIT, `LICENSE`), which Video Director's
Sound engineering steps run. It is not a skill of its own: Video Director has one `SKILL.md`, and what it needs from
real-sfx's instructions is written into Video Director's `references/real-sfx-scripts.md` and `references/sound-stage.md`.

- Source: https://github.com/Clipwing/skills, folder `skills/real-sfx`
- Commit: `edbefcbc3474869e6cc1e8a7ca583b0efd0dab7e`
- Copied: 2026-11-06
- Instructions folded into Video Director: 2026-11-10

## What is kept, and what the sync does with each part

`tools/sync-real-sfx.sh` (at the top of the Video Director repository) compares Clipwing's latest change with the
commit above. Once a week, a scheduled Claude task on the maintainer's Mac runs it, tests the result and opens a pull
request when there is anything new.

| Clipwing's files | Here | When Clipwing changes them |
|---|---|---|
| `scripts/` (all but `package.py`), `tests/selftest.py`, `tests/resound.py`, `vendor/`, `config.json`, `config.example.json`, `references/profiles/` | kept, in the same places: the scripts find their settings, the uisfx pack and the profiles through this folder | applied here, keeping the changes listed below |
| `SKILL.md`, `README.md`, `references/*.md`, `tests/resound.md`, any other `.md` file | removed: their instructions were for real-sfx as a skill on its own | listed for a person to review, never copied in. Fold anything Video Director needs into `references/real-sfx-scripts.md` or `references/sound-stage.md`, in Video Director's own words and defaults |
| `evals/` | removed: real-sfx's own trigger and output tests | listed for review, never copied in |
| `scripts/package.py` | removed: it packaged real-sfx as a skill of its own | listed for review, never copied in |

A new file from Clipwing outside those removed parts is applied with the scripts. If a script needs a removed file, the
self-test fails: bring the file back and take it off the removed list in `tools/sync-real-sfx.sh`.

`tests/resound.py` stays because the self-test checks it. It gives a fresh agent a skill's `SKILL.md`, so it only works
on Clipwing's own copy, not this folder.

## Changes made here

Each one stays when Clipwing's later changes are brought in. If Clipwing changes the same lines, the update stops and
shows both versions.

| File | Change | Why |
|---|---|---|
| `LICENSE` | added: the standard MIT text, Alexander Korbanov (Clipwing) | Clipwing's README gives the scripts as MIT; the folder had no licence file |
| `scripts/setup.py` | `check` finds the index through `index_path()`, so it honours `REAL_SFX_INDEX` | with the index kept in `~/.config/real-sfx/`, `check` reported it missing |
| the removed files above | deleted | one skill, one `SKILL.md`; Video Director's sound defaults (few sounds, no bed, levels set against the music) replace real-sfx's |
| `UPSTREAM.md` | this file | |
