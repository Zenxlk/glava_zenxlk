#!/usr/bin/env bash

# shellcheck source=/home/khing/.local/bin/hyde-shell
# shellcheck disable=SC1091
if ! source "$(command -v hyde-shell)"; then
    echo "[wallbash] glava :: Error: hyde-shell not found."
    echo "[wallbash] glava :: Is HyDE installed?"
    exit 1
fi

if pkg_installed glava; then
    if pgrep -x glava >/dev/null; then
        pkill -x glava
        sleep 0.3
        setsid -f glava -d >/dev/null 2>&1 &
    fi
fi
