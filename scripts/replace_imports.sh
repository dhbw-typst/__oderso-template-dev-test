#!/usr/bin/env bash
set -eo pipefail

usage() {
    echo "Usage: $0 [options] <file|dir>..."
    echo "  -l, --local      replace with @local/PKG_NAME:VERSION (default: @preview/)"
    echo "  -m, --manifest   path to typst.toml (default: ./typst.toml)"
    echo "  -h, --help"
    exit 1
}

LOCAL=false
TOML="typst.toml"
FILES=()

while [[ $# -gt 0 ]]; do
    case "$1" in
        -l|--local)    LOCAL=true; shift ;;
        -m|--manifest) TOML="$2"; shift 2 ;;
        -h|--help)     usage ;;
        -*)            echo "Unknown option: $1" >&2; usage ;;
        *)             FILES+=("$1"); shift ;;
    esac
done

PKG_NAME=$(yq -p toml -oy '.package.name' "$TOML")
PKG_VERSION=$(yq -p toml -oy '.package.version' "$TOML")

if [[ "$LOCAL" == true ]]; then
    NAMESPACE="@local"
else
    NAMESPACE="@preview"
fi

find "${FILES[@]}" \
    -name "*.typ" \
    -exec sed -i -E 's|#import "[./]*(template/)?lib\.typ"|#import "'"${NAMESPACE}/${PKG_NAME}:${PKG_VERSION}"'"|g' {} +
