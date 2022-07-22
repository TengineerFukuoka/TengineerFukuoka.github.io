#!/usr/bin/env bash
set -eu

if [ $# -lt 1 ]; then
    echo 'source file required' >&2
    exit 1
fi

src_top="$(cd "$(dirname "${BASH_SOURCE:-0}")/.."; pwd)"

article="${1}"

articles="$(printf '!%s\n' '' "${src_top}/src/article/"*"/index.md" '' | grep -C 1 "${article}")"

prev="$(head -1 <<<"${articles}" | sed 's/^!//')"
next="$(tail -1 <<<"${articles}" | sed 's/^!//')"

pandoc_vars=()
if [ ! -z  "${prev}" ]; then
    unset title
    source <(pandoc -f Markdown -t HTML --template="${src_top}/src/template/article-info.html" "${prev}")
    pandoc_vars+=(
        "--variable=prev-post:$(basename "$(dirname "${prev}")")"
        "--variable=prev-title:${title}"
    )
fi

if [ ! -z  "${next}" ]; then
    unset title
    source <(pandoc -f Markdown -t HTML --template="${src_top}/src/template/article-info.html" "${next}")
    pandoc_vars+=(
        "--variable=next-post:$(basename "$(dirname "${next}")")"
        "--variable=next-title:${title}"
    )
fi

unset title date
source <(pandoc -f Markdown -t HTML --template="${src_top}/src/template/article-info.html" "${article}")
source <(grep -E '^[0-9]+\.[0-9]+\.[0-9]+$' <<<"${date}" | sed -E 's@^([0-9]+)\.([0-9]+)\.([0-9]+)$@y=\1 m=\2 d=\3@')

wd="$(LANG=C date --date="$y-$m-$d" +%a)"
pandoc_vars+=(
    "--variable=event-yr:${y}"
    "--variable=event-mo:${m}"
    "--variable=event-day:${d}"
    "--variable=event-wd:${wd}"
    "--variable=event-wd-class:$(sed 'y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/' <<<"${wd}")"
)

pandoc -f Markdown -t HTML --template="${src_top}/src/template/article.html" --toc "${pandoc_vars[@]}" "${article}"
