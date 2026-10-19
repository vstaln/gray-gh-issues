#!/bin/sh
here="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
sys="$(uname -s)"
case "$sys" in
MINGW* | MSYS* | CYGWIN*) rel="x86_64-pc-windows-msvc/gray-gh-issues.exe" ;;
Darwin*)
    case "$(uname -m)" in
    arm64) rel="aarch64-apple-darwin/gray-gh-issues" ;;
    *) rel="x86_64-apple-darwin/gray-gh-issues" ;;
    esac ;;
*)
    case "$(uname -m)" in
    aarch64 | arm64) rel="aarch64-unknown-linux-musl/gray-gh-issues" ;;
    *) rel="x86_64-unknown-linux-musl/gray-gh-issues" ;;
    esac ;;
esac
if [ -x "$here/$rel" ]; then exec "$here/$rel" "$@"; fi
for cand in "$here/target/release/gray-gh-issues.exe" "$here/target/release/gray-gh-issues" "$here/target/debug/gray-gh-issues.exe" "$here/target/debug/gray-gh-issues"; do
    if [ -x "$cand" ]; then exec "$cand" "$@"; fi
done
echo "gray-gh-issues binary not found in $here" >&2
exit 1
