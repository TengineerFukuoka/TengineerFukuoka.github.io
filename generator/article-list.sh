#!/usr/bin/env bash
set -eu

src_top="$(cd "$(dirname "${BASH_SOURCE:-0}")/.."; pwd)"

find "${src_top}/src/article/" -maxdepth 1 -mindepth 1 -type d | sort | head -n "${ARTICLE_LIMIT:--0}" |
    while read article; do
        unset title date y m d
        source <(pandoc -f Markdown -t HTML --template="${src_top}/src/template/article-info.html" "${article}/index.md")
        source <(grep -E '^[0-9]+\.[0-9]+\.[0-9]+$' <<<"${date}" | sed -E 's@^([0-9]+)\.([0-9]+)\.([0-9]+)$@y=\1 m=\2 d=\3@')
        wd="$(LANG=C date --date="$y-$m-$d" +%a)"
        cat <<EOF
<a href="${ARTICLE_PATH_PREFIX:-}$(basename "${article}")/" class="articles-item-link">
  <div class="ev-row">
    <div class="ev-date">
      <div class="ev-yr">${y}</div>
      <div class="ev-day">${m}/${d}</div>
    </div>
    <div class="ev-weekday $(sed 'y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/' <<<"${wd}")">${wd}</div>
    <div class="ev-title">${title}</div>
  </div>
</a>
EOF
    done
