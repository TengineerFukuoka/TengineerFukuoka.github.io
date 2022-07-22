#!/usr/bin/env bash
set -eu

dir="$(cd "$(dirname "${BASH_SOURCE:-0}")"; pwd)"

rm -rf "${dir}/public"

mkdir -p "${dir}/public"

python "${dir}/generator/top-page.py" "${dir}/src/template/index.html" "${dir}/generator/article-list.sh" "${dir}/src/events.csv" >"${dir}/public/index.html"
cp "${dir}/src/static/"{favicon.ico,style.css} "${dir}/public/."

for article in "${dir}/src/article/"*; do
    article_name="$(basename "${article}")"
    article_dir="${dir}/public/article/${article_name}"
    mkdir -p "${article_dir}"

    bash "${dir}/generator/single.sh" "${article}/index.md" >"${article_dir}/index.html"

    find "${article}" -type f -not -name 'index.md' -exec cp \{\} "${article_dir}" \;
done

python "${dir}/generator/articles.py" "${dir}/src/template/articles.html" "${dir}/generator/article-list.sh" >"${dir}/public/article/index.html"
