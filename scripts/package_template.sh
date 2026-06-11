#!/usr/bin/env bash
set -eo pipefail

usage() {
    echo "Usage: $0 [options]"
    echo "  -t, --target-dir <path>     install destination (default: typst local packages path)"
    echo "  -m, --manifest <file>       path to typst.toml (default: ./typst.toml)"
    echo "  -p, --package-file <file>   file to copy into BASE/template (repeatable)"
    echo "  -e, --example-file <file>   file to copy into BASE/example (repeatable)"
    echo "  -a, --additional-file <file> file to copy into BASE (repeatable)"
    echo "  -h, --help"
    exit 1
}

TARGET_DIR=""
TOML="typst.toml"
_pkg_files=()
_ex_files=()
_add_files=()

while [[ $# -gt 0 ]]; do
    case "$1" in
        -t|--target-dir)       TARGET_DIR="$2"; shift 2 ;;
        -m|--manifest)         TOML="$2"; shift 2 ;;
        -p|--package-file)     _pkg_files+=("$2"); shift 2 ;;
        -e|--example-file)     _ex_files+=("$2"); shift 2 ;;
        -a|--additional-file)  _add_files+=("$2"); shift 2 ;;
        -h|--help)             usage ;;
        *) echo "Unknown option: $1" >&2; usage ;;
    esac
done

if [[ -z "$TARGET_DIR" ]]; then
    PKG_PATH=$(typst info -f json 2>/dev/null | jq -r '.packages["package-path"]')
    TARGET_DIR="${PKG_PATH}/local"
fi

PKG_NAME=$(yq -p toml -oy '.package.name' "$TOML")
PKG_VERSION=$(yq -p toml -oy '.package.version' "$TOML")

BASE="${TARGET_DIR}/${PKG_NAME}/${PKG_VERSION}"

echo "Installing to: $BASE"
mkdir -p "$BASE/template" "$BASE/example"

copy_files() {
    local dest="$1"
    shift
    for f in "$@"; do
        cp -r "$f" "$dest/"
        echo "  copied: $f -> $dest/"
    done
}

copy_files "$BASE/template" "${_pkg_files[@]}"
copy_files "$BASE/example"  "${_ex_files[@]}"
copy_files "$BASE"          "${_add_files[@]}"

echo "Done."
