#!/usr/bin/env bash
# Bring Clipwing's later changes to real-sfx into Video Director's copy (skills/video-director/real-sfx).
#
#   tools/sync-real-sfx.sh            apply what Clipwing changed since the commit in real-sfx/UPSTREAM.md
#   tools/sync-real-sfx.sh --check    only say whether there is anything new
#
# It takes the difference between the recorded commit and Clipwing's latest change to skills/real-sfx, and applies
# just that difference to this copy, so the changes made here (listed in UPSTREAM.md) stay. Where Clipwing changed
# the same lines, git leaves both versions in the file between <<<<<<< and >>>>>>> marks, and this script lists those
# files. It then records the new commit in UPSTREAM.md. Nothing is committed.
#
# Exit: 0 up to date, or applied cleanly; 2 applied, with files to resolve by hand; 10 (--check) something new;
# 1 an error. REAL_SFX_UPSTREAM names another repository to fetch from (the tests use a local one).
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
    -h|--help) sed -n '2,15p' "$0"; exit 0 ;;
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

echo "Clipwing changed real-sfx since ${REC:0:7}:"
git log --format='  %h %ad %s' --date=short "$REC..$NEW" -- "$SRC"
git diff --stat "$REC" "$NEW" -- "$SRC" | sed 's/^/  /'
if [ "$CHECK" = 1 ]; then
  exit 10
fi

if ! git diff --quiet HEAD -- "$DEST" || [ -n "$(git ls-files --others --exclude-standard -- "$DEST")" ]; then
  echo "error: $DEST has changes that aren't committed; commit or stash them first" >&2; exit 1
fi

PATCH=$(mktemp)
trap 'rm -f "$PATCH"' EXIT
git diff --binary "$REC" "$NEW" -- "$SRC" > "$PATCH"
code=0
git apply --3way -p3 --directory="$DEST" "$PATCH" || code=$?

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

conflicts=$(git diff --name-only --diff-filter=U -- "$DEST")
if [ "$code" -ne 0 ] || [ -n "$conflicts" ]; then
  echo
  echo "Applied with conflicts. Clipwing changed lines that were also changed here; resolve each file by hand"
  echo "(keep both changes where you can), then check UPSTREAM.md's list of changes still holds:"
  if [ -n "$conflicts" ]; then echo "$conflicts" | sed 's/^/  /'; else echo "  (git apply failed: see its message above)"; fi
  exit 2
fi
echo
echo "Applied cleanly; UPSTREAM.md now records ${NEW:0:7}. Next: run real-sfx's self-test"
echo "(python3 $DEST/tests/selftest.py) and Video Director's script tests, then commit."
