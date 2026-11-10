#!/usr/bin/env bash
# Bring Clipwing's later changes to real-sfx's scripts into Video Director (skills/video-director/real-sfx).
#
#   tools/sync-real-sfx.sh            apply what Clipwing changed since the commit in real-sfx/UPSTREAM.md
#   tools/sync-real-sfx.sh --check    only say whether there is anything new
#
# Video Director keeps real-sfx's scripts, tests, vendor folder and settings files, and none of its instructions
# (SKILL.md, README.md, the other .md files, evals/, scripts/package.py): what it needs from those is written into
# Video Director's own references. So the difference between the recorded commit and Clipwing's latest change to
# skills/real-sfx is split in two. Changes to the kept files are applied here, keeping the changes made here (listed in
# UPSTREAM.md); where Clipwing changed the same lines, git leaves both versions between <<<<<<< and >>>>>>> marks and
# this script lists those files. Changes to the removed files are only listed, for a person to review. It then records
# the new commit in UPSTREAM.md. Nothing is committed.
#
# Exit: 0 up to date, or applied cleanly with nothing to review; 2 applied, with files to resolve by hand; 3 applied
# cleanly, and Clipwing changed instructions a person should review; 10 (--check) something new; 1 an error.
# REAL_SFX_UPSTREAM names another repository to fetch from (the tests use a local one).
set -euo pipefail

ROOT=$(git rev-parse --show-toplevel)
DEST=skills/video-director/real-sfx
SRC=skills/real-sfx
UPSTREAM=${REAL_SFX_UPSTREAM:-https://github.com/Clipwing/skills.git}
BRANCH=main
CHECK=0
for arg in "$@"; do
  case "$arg" in
    --check) CHECK=1 ;;
    -h|--help) sed -n '2,17p' "$0"; exit 0 ;;
    *) echo "error: unknown option $arg" >&2; exit 1 ;;
  esac
done

cd "$ROOT"
RECORD="$DEST/UPSTREAM.md"
REC=$(sed -n 's/^- Commit: `\([0-9a-f]\{40\}\)`.*/\1/p' "$RECORD")
if [ -z "$REC" ]; then
  echo "error: no '- Commit: \`<40-character id>\`' line in $RECORD" >&2; exit 1
fi

git fetch -q --no-tags "$UPSTREAM" "$BRANCH"
TIP=$(git rev-parse FETCH_HEAD)
NEW=$(git log -1 --format=%H "$TIP" -- "$SRC")
if [ -z "$NEW" ]; then
  echo "error: $UPSTREAM ($BRANCH) has no $SRC folder; has Clipwing moved it?" >&2; exit 1
fi
if ! git cat-file -e "$REC^{commit}" 2>/dev/null; then
  echo "error: the recorded commit $REC isn't in $UPSTREAM ($BRANCH) any more (history rewritten?); compare by hand" >&2
  exit 1
fi
if [ "$NEW" = "$REC" ] || git merge-base --is-ancestor "$NEW" "$REC"; then
  echo "real-sfx is up to date with Clipwing (${REC:0:7})."
  exit 0
fi

# Removed here: Clipwing's instructions, its own tests of them, and its packaging script.
left_out() {
  case "$1" in
    vendor/*) return 1 ;;
    *.md|evals/*|scripts/package.py) return 0 ;;
    *) return 1 ;;
  esac
}
KEEP=(); REVIEW=()
while IFS= read -r -d '' f; do
  if left_out "${f#$SRC/}"; then REVIEW+=("$f"); else KEEP+=("$f"); fi
done < <(git diff -z --name-only --no-renames "$REC" "$NEW" -- "$SRC")

echo "Clipwing changed real-sfx since ${REC:0:7}:"
git log --format='  %h %ad %s' --date=short "$REC..$NEW" -- "$SRC"
if [ ${#KEEP[@]} -gt 0 ]; then
  echo "Scripts and other kept files (applied here):"
  git diff --stat --no-renames "$REC" "$NEW" -- "${KEEP[@]}" | sed 's/^/  /'
fi
if [ ${#REVIEW[@]} -gt 0 ]; then
  echo "Instructions and other removed files (not copied; for a person to review):"
  git diff --stat --no-renames "$REC" "$NEW" -- "${REVIEW[@]}" | sed 's/^/  /'
fi
if [ "$CHECK" = 1 ]; then
  exit 10
fi

if ! git diff --quiet HEAD -- "$DEST" || [ -n "$(git ls-files --others --exclude-standard -- "$DEST")" ]; then
  echo "error: $DEST has changes that aren't committed; commit or stash them first" >&2; exit 1
fi

code=0
if [ ${#KEEP[@]} -gt 0 ]; then
  PATCH=$(mktemp)
  trap 'rm -f "$PATCH"' EXIT
  git diff --binary --no-renames "$REC" "$NEW" -- "${KEEP[@]}" > "$PATCH"
  git apply --3way -p3 --directory="$DEST" "$PATCH" || code=$?
fi

today=$(date +%Y-%m-%d)
python3 - "$RECORD" "$NEW" "$today" <<'PY'
import re, sys
path, new, today = sys.argv[1:]
text = open(path, encoding="utf-8").read()
text = re.sub(r"^- Commit: `[0-9a-f]{40}`.*$", f"- Commit: `{new}`", text, count=1, flags=re.M)
if re.search(r"^- Updated: .*$", text, flags=re.M):
    text = re.sub(r"^- Updated: .*$", f"- Updated: {today}", text, count=1, flags=re.M)
else:
    text = re.sub(r"^(- Copied: .*)$", rf"\1\n- Updated: {today}", text, count=1, flags=re.M)
open(path, "w", encoding="utf-8").write(text)
PY

review_note() {
  [ ${#REVIEW[@]} -gt 0 ] || return 0
  echo
  echo "Clipwing also changed instructions that Video Director doesn't copy. Read what changed:"
  echo "  git diff $REC $NEW -- ${REVIEW[*]}"
  if [ "$UPSTREAM" = "https://github.com/Clipwing/skills.git" ]; then
    echo "  https://github.com/Clipwing/skills/compare/$REC...$NEW"
  fi
  echo "Fold anything that changes how the scripts are run into references/real-sfx-scripts.md or"
  echo "references/sound-stage.md, in Video Director's words and with its own sound defaults."
}

conflicts=$(git diff --name-only --diff-filter=U -- "$DEST")
if [ "$code" -ne 0 ] || [ -n "$conflicts" ]; then
  echo
  echo "Applied with conflicts. Clipwing changed lines that were also changed here; resolve each file by hand"
  echo "(keep both changes where you can), then check UPSTREAM.md's list of changes still holds:"
  if [ -n "$conflicts" ]; then echo "$conflicts" | sed 's/^/  /'; else echo "  (git apply failed: see its message above)"; fi
  review_note
  exit 2
fi
echo
if [ ${#KEEP[@]} -gt 0 ]; then
  echo "Applied cleanly; UPSTREAM.md now records ${NEW:0:7}. Next: run real-sfx's self-test"
  echo "(python3 $DEST/tests/selftest.py) and Video Director's script tests, then commit."
else
  echo "No script changes to apply; UPSTREAM.md now records ${NEW:0:7}."
fi
if [ ${#REVIEW[@]} -gt 0 ]; then
  review_note
  exit 3
fi
