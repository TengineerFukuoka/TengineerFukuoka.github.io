#!/usr/bin/env bash

dir="$(cd "$(dirname "${BASH_SOURCE:-0}")"; pwd)"

if [ "${REQUIRE_NGINX}" = yes ]; then
    nginx
fi

inotifywait -m -r -e close_write src |
    while read; do
        "${dir}/gen.sh" || echo 'Generation failed' && echo 'Rebuilt'
    done
