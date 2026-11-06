# Video Director

**A Claude Code skill that directs short videos from brief to finished render.** Product launch films, explainers, brand films, designed demos, vertical social shorts, event and data videos, and live-action story ads, from about 6 seconds to 3 minutes, mixing motion graphics with photos, footage and generated clips.

You direct; Claude designs and builds. Nothing is animated until you have approved it as still frames, and every visual decision is a pick from 2-3 real options, never a reaction to one take.

## What's inside

- **Rules measured from real films, not guessed.** Text sizes, positions, reading times and motion rules come from measuring 59 films across seven types. The visual ideas come from studying 34 films and ads. The lessons from building real films were checked against 56 more before they became rules.
- **8 video types**, each with its own defaults, films worth studying, and a "default versus better" table: product launch, explainer, brand film, demo or tutorial, social short, event, recap or data, showcase, and live-action story.
- **57 animation styles**, grouped by lead medium, each with an example film to look up.
- **A zoomable storyboard page** you can pin notes to, a motion spec with a named move, timing and easing for every change, and an animated test before the full build.
- **Render checks** in Python: frames on both sides of every cut, choppy motion, text size and reading time by role, sound levels, continuity between shots, delivery specs, and an optional motion watch by a video model.

## How it works

1. Brief and script. It asks whether to study reference films or build from scratch.
2. Design options for direction and color, shown as still frames.
3. A storyboard page you review and annotate.
4. A motion spec for every change on screen.
5. An animated test, then the full film, built with [HyperFrames](https://github.com/heygen-com/hyperframes).
6. Render checks, then polish rounds until you sign off.

## Install

In Claude Code:

```
/plugin marketplace add SallyRS/video-director
/plugin install video-director@video-director
```

Or copy `skills/video-director/` into `~/.claude/skills/`.

## Needs

- Python 3 and [ffmpeg](https://ffmpeg.org/) for the render checks.
- [HyperFrames](https://github.com/heygen-com/hyperframes) for the build.
- Optional: [yt-dlp](https://github.com/yt-dlp/yt-dlp) to study reference films, a clip tool such as [Higgsfield](https://higgsfield.ai/) for generated footage, [Codex](https://github.com/openai/codex) for stills, and a [Gemini API](https://ai.google.dev/) key for the motion watch (`scripts/watch_cut.py`). The skill works without them and says what it can't check.

## Credits

Built on and informed by other people's open work:

- **[HyperFrames](https://github.com/heygen-com/hyperframes)** by HeyGen: the HTML-to-video engine every film is built with.
- **[motion-video-kit](https://github.com/echris6/motion-video-kit)** by echris6 (MIT): its measured rules from professional launch films shaped how this skill carries objects across cuts and treats reference films as something to measure, not imitate.
- **[saas-motion-kit](https://github.com/tugrawork-creator/saas-motion-kit)** by tugrawork-creator (MIT): its variety rules for shot length, easing and transitions in HyperFrames films.
- **[motionmaxxing](https://github.com/Tejashmakwana/motionmaxxing)** by Tejashmakwana (Apache-2.0): the finding that a gallery of example films makes every brand look the same, which is why this skill pairs a default with a better decision instead.
- **[onetake](https://github.com/feitangyuan/onetake)** by feitangyuan: its numbers on rhythm and what carries across a cut. Ideas only; no text or code is used.
- **[Jesse Eisenbart's 20-style showcase](https://www.tiktok.com/@jesseeisenbart/video/7697657520793324818)**: the starting point for the animation style list.

The films named inside the skill are cited as examples to study. No footage, layouts or brand looks from them are included.

## License

MIT
