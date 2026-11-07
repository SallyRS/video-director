#!/usr/bin/env python3
"""Build the animation style page: one example picture per style in references/animation-styles.md, by group.

python3 <skill>/scripts/build_style_library.py --out <project>/references/styles-v1.html \
    [--suggest "flat-vector=Clear for a process with many parts" --suggest "..."]

Every style is always shown. --suggest puts a style at the top with a one-line reason; give it 3-4 times, for
different styles. The style id is the picture's file name without its extension. The pictures are copied into
a style-library/ folder next to the page, so the page still works when the project is moved or shared.
It never overwrites a page: use a new version number. The one exception is the library's own index.html.
Exit 0: page written; 1: a style's picture is missing, the page exists, or an argument is wrong.
"""
from __future__ import annotations

import argparse
import html
import os
from pathlib import Path
import re
import shutil
import sys

SKILL = Path(__file__).resolve().parent.parent
STYLES = SKILL / "references" / "animation-styles.md"
LIBRARY = SKILL / "assets" / "style-library"
SHOWCASE = "https://www.tiktok.com/@jesseeisenbart/video/7697657520793324818"
LINK = re.compile(r"\[[^\]]*\]\(([^)]+)\)")


def parse(text: str) -> list[dict]:
    """Return [{group, styles: [{id, name, looks, example, good_for, picture}]}] from the style tables."""
    groups, group, header = [], None, None
    for line in text.splitlines():
        if line.startswith("## "):
            group, header = {"group": line[3:].strip(), "styles": []}, None
            groups.append(group)
            continue
        if group is None or not line.startswith("|"):
            continue
        cells = [c.strip() for c in line.strip().strip("|").split("|")]
        if header is None:
            header = [c.lower() for c in cells]
            continue
        if set(cells[0]) <= set("-: "):
            continue
        row = dict(zip(header, cells))
        link = LINK.search(row.get("picture", ""))
        if not link:
            raise ValueError(f"{row.get('style', cells[0])}: no picture link in the Picture column")
        picture = (STYLES.parent / link.group(1)).resolve()
        group["styles"].append({"id": picture.stem, "name": row["style"], "looks": row["what it looks like"],
                                "example": row["example to study"], "good_for": row["consider for"],
                                "picture": picture})
    return [g for g in groups if g["styles"]]


def inline(text: str) -> str:
    """Escape a table cell and keep its *italics*."""
    return re.sub(r"\*([^*]+)\*", r"<em>\1</em>", html.escape(text))


def example(text: str) -> str:
    if text.startswith("Showcase "):
        return f'<a href="{SHOWCASE}">Jesse Eisenbart\'s 20-style showcase</a>, {inline(text[9:])}'
    return inline(text)


def src(picture: Path, out: Path) -> str:
    try:
        return os.path.relpath(picture, out.parent)
    except ValueError:
        return picture.as_uri()


def card(s: dict, out: Path, reason: str | None = None) -> str:
    why = f'<p class="why">{html.escape(reason)}</p>' if reason else ""
    anchor = f'suggested-{s["id"]}' if reason else s["id"]
    return (f'<figure class="card" id="{anchor}"><button class="pic" type="button" aria-label="Enlarge {html.escape(s["name"])}">'
            f'<img src="{html.escape(src(s["picture"], out))}" alt="{html.escape(s["name"])} example" loading="lazy" width="768" height="432"></button>'
            f'<figcaption><h3>{html.escape(s["name"])}</h3>{why}<p>{inline(s["looks"])}.</p>'
            f'<p class="meta"><span>Good for:</span> {inline(s["good_for"])}</p>'
            f'<p class="meta"><span>Look up:</span> {example(s["example"])}</p></figcaption></figure>')


PAGE = """<!doctype html>
<html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>Animation styles</title>
<style>
:root{--bg:#f4f6f8;--card:#fff;--ink:#16191d;--muted:#5b6470;--line:#dde2e8;--accent:#2357d9}
@media (prefers-color-scheme:dark){:root{--bg:#111418;--card:#1b1f25;--ink:#eef1f4;--muted:#9aa4b0;--line:#2b313a;--accent:#7ea2ff}}
*{box-sizing:border-box}body{margin:0;background:var(--bg);color:var(--ink);font:15px/1.45 -apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,sans-serif}
main{max-width:1320px;margin:0 auto;padding:28px 16px 64px}
h1{font-size:26px;margin:0 0 6px}.lede{color:var(--muted);margin:0 0 14px;max-width:760px}
nav{display:flex;flex-wrap:wrap;gap:8px;margin:0 0 8px}nav a{color:var(--ink);text-decoration:none;border:1px solid var(--line);background:var(--card);border-radius:999px;padding:4px 12px;font-size:13px}
h2{font-size:20px;margin:36px 0 4px}.count{color:var(--muted);font-weight:400;font-size:14px}
.grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(270px,1fr));gap:16px;margin-top:12px}
.card{margin:0;background:var(--card);border:1px solid var(--line);border-radius:10px;overflow:hidden}
.suggested .card{border:2px solid var(--accent)}
.pic{display:block;width:100%;padding:0;border:0;background:#000;cursor:zoom-in}.pic img{display:block;width:100%;height:auto;aspect-ratio:16/9;object-fit:cover}
figcaption{padding:10px 12px 12px}h3{font-size:15px;margin:0 0 4px}figcaption p{margin:0 0 6px}
.why{color:var(--accent);font-weight:600}.meta{color:var(--muted);font-size:13px}.meta span{font-weight:600}
a{color:var(--accent)}
dialog{border:0;padding:0;background:transparent;max-width:min(1200px,96vw)}dialog::backdrop{background:rgba(0,0,0,.85)}
dialog img{display:block;max-width:100%;max-height:80vh;border-radius:6px}dialog p{color:#fff;margin:8px 0 0;font-size:15px}
</style></head><body><main>
<h1>Animation styles</h1>
<p class="lede">Ways of drawing or building the pictures in motion graphics and animation. Most pictures show the same desk by a window, so you can compare styles side by side. Pick one or more to see as directions for your film, describe the look you want in your own words, or say "you choose". Click a picture to see it larger.</p>
__NAV__
__BODY__
</main>
<dialog id="big"><img alt=""><p></p></dialog>
<script>
const d=document.getElementById('big');
document.querySelectorAll('.pic').forEach(b=>b.addEventListener('click',()=>{const i=b.querySelector('img');d.querySelector('img').src=i.src;d.querySelector('p').textContent=i.alt.replace(/ example$/,'');d.showModal();}));
d.addEventListener('click',()=>d.close());
</script></body></html>
"""


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--out", type=Path, required=True)
    ap.add_argument("--suggest", action="append", default=[], metavar="ID=REASON")
    args = ap.parse_args()
    out = args.out.resolve()
    if out.exists() and out != LIBRARY / "index.html":
        print(f"FAIL {out} exists. Use a new version number; earlier pages stay as the record.", file=sys.stderr)
        return 1
    try:
        groups = parse(STYLES.read_text(encoding="utf-8"))
    except (ValueError, KeyError) as e:
        print(f"FAIL animation-styles.md: a table row is wrong ({e})", file=sys.stderr)
        return 1
    by_id = {s["id"]: s for g in groups for s in g["styles"]}
    missing = [s["name"] for s in by_id.values() if not s["picture"].is_file()]
    if missing:
        print("FAIL missing pictures: " + ", ".join(missing), file=sys.stderr)
        return 1
    suggestions = []
    for item in args.suggest:
        sid, _, reason = item.partition("=")
        if sid.strip() not in by_id:
            print(f"FAIL unknown style id: {sid.strip()}", file=sys.stderr)
            return 1
        if not reason.strip():
            print(f"FAIL no reason given for {sid.strip()}: write ID=one plain line", file=sys.stderr)
            return 1
        suggestions.append((by_id[sid.strip()], reason.strip()))
    ids = [s["id"] for s, _ in suggestions]
    if suggestions and not 3 <= len(ids) <= 4:
        print(f"FAIL suggest 3-4 styles, not {len(ids)}", file=sys.stderr)
        return 1
    if len(set(ids)) != len(ids):
        print("FAIL the same style is suggested twice", file=sys.stderr)
        return 1
    if out.parent != LIBRARY:
        folder = out.parent / "style-library"
        folder.mkdir(parents=True, exist_ok=True)
        for s in by_id.values():
            dest = folder / s["picture"].name
            if not dest.is_file() or dest.stat().st_size != s["picture"].stat().st_size:
                shutil.copy2(s["picture"], dest)
            s["picture"] = dest
    parts, nav = [], []
    if suggestions:
        nav.append('<a href="#suggested">Suggested</a>')
        parts.append('<section class="suggested" id="suggested"><h2>Suggested for this film</h2><div class="grid">'
                     + "".join(card(s, out, r) for s, r in suggestions) + "</div></section>")
    for i, g in enumerate(groups):
        nav.append(f'<a href="#g{i}">{html.escape(g["group"])}</a>')
        parts.append(f'<section id="g{i}"><h2>{html.escape(g["group"])} <span class="count">{len(g["styles"])}</span></h2>'
                     '<div class="grid">' + "".join(card(s, out) for s in g["styles"]) + "</div></section>")
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(PAGE.replace("__NAV__", "<nav>" + "".join(nav) + "</nav>").replace("__BODY__", "\n".join(parts)), encoding="utf-8")
    print(f"PASS {len(by_id)} styles in {len(groups)} groups, {len(suggestions)} suggested: {out}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
