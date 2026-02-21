#!/usr/bin/env bash
# Updates CSS/JS references in all HTML files with a content-based hash
# for cache busting. Run before deploying.

set -euo pipefail
cd "$(dirname "$0")"

css_hash=$(md5 -q css/style.css | cut -c1-8)
js_hash=$(md5 -q js/main.js | cut -c1-8)

for f in *.html; do
  sed -i '' -E "s|css/style\.css(\?v=[a-f0-9]+)?|css/style.css?v=${css_hash}|g" "$f"
  sed -i '' -E "s|js/main\.js(\?v=[a-f0-9]+)?|js/main.js?v=${js_hash}|g" "$f"
done

echo "Cache busted: style.css?v=${css_hash} main.js?v=${js_hash}"
