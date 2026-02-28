#!/usr/bin/env bash
# Updates CSS/JS cache-bust params in Jekyll includes.
# The includes use: {{ '/css/style.css' | relative_url }}?v=HASH
# This script updates the ?v=HASH portion.

set -euo pipefail
cd "$(dirname "$0")/.."

css_hash=$(md5 -q css/style.css | cut -c1-8)
js_hash=$(md5 -q js/main.js | cut -c1-8)

sed -i '' -E "s|(style\.css.+)\?v=[a-f0-9]+|\1?v=${css_hash}|g" _includes/head.html
sed -i '' -E "s|(main\.js.+)\?v=[a-f0-9]+|\1?v=${js_hash}|g" _includes/footer.html

echo "Cache busted: style.css?v=${css_hash} main.js?v=${js_hash}"
