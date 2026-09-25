#!/usr/bin/env bash

set -u

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
METADATA_FILE="$SCRIPT_DIR/.llmp-install-metadata"

if [[ ! -f "$METADATA_FILE" ]]; then
  printf 'uninstall.sh: no install metadata found.\n' >&2
  printf 'Nothing to uninstall.\n'
  exit 0
fi

# shellcheck disable=SC1090
source "$METADATA_FILE"

if [[ ! -L "$BIN_LINK" ]]; then
  if [[ -e "$BIN_LINK" ]]; then
    printf 'Leaving real path untouched: %s\n' "$BIN_LINK"
    printf '\nInstall metadata kept because the path was not a symlink.\n'
    exit 1
  fi

  printf 'Already absent: %s\n' "$BIN_LINK"
  rm -f "$METADATA_FILE"

  printf '\nUninstall complete.\n'
  printf 'The repository and prompt files were not removed.\n'
  exit 0
fi

actual_target="$(readlink "$BIN_LINK")"

if [[ "$actual_target" != "$BIN_TARGET" ]]; then
  printf 'Leaving symlink with unexpected target untouched: %s\n' "$BIN_LINK"
  printf '  expected: %s\n' "$BIN_TARGET"
  printf '  actual:   %s\n' "$actual_target"
  printf '\nInstall metadata kept because the symlink was not created by this installation.\n'
  exit 1
fi

if ! rm "$BIN_LINK"; then
  printf 'uninstall.sh: could not remove symlink: %s\n' "$BIN_LINK" >&2
  exit 1
fi

printf 'Removed symlink: %s\n' "$BIN_LINK"

rm -f "$METADATA_FILE"

printf '\nUninstall complete.\n'
printf 'The repository and prompt files were not removed.\n'
