# Video Director

A Claude Code skill for making short videos, from about 6 seconds to 3 minutes, that mix motion graphics with photos, footage and generated clips. It covers product launch films, explainers, brand films, designed demos, vertical social shorts, event and data videos, and live-action story ads.

You direct; Claude designs and builds. Nothing is animated until you have approved it as still frames, and every visual decision is a pick from 2-3 real options.

## What it does

1. Takes a brief and script.
2. Shows design options for direction and color.
3. Builds a zoomable storyboard page you can leave notes on.
4. Writes a motion spec: a named move, timing and easing for every change.
5. Renders an animated test, then the full film with [HyperFrames](https://github.com/heygen-com/hyperframes).
6. Checks the render: frames on both sides of every cut, choppy motion, text, sound levels and delivery specs.

## Install

In Claude Code:

```
/plugin marketplace add SallyRS/video-director
/plugin install video-director@video-director
```

Or copy `skills/video-director/` into `~/.claude/skills/`.

## Needs

- Python 3 and `ffmpeg` for the bundled checks.
- HyperFrames for the build.
- Optional: a clip tool such as Higgsfield for generated footage, and a `GEMINI_API_KEY` for the motion watch (`scripts/watch_cut.py`). The skill works without them and says what it can't check.

## License

MIT
