#!/usr/bin/env bash
# Updates CSS/JS references in all HTML files with a content-based hash
# for cache busting. Run before deploying.

set -euo pipefail
cd "$(dirname "$0")/.."

css_hash=$(md5 -q css/style.css | cut -c1-8)
js_hash=$(md5 -q js/main.js | cut -c1-8)

bust() { find . -name "*.html" -not -path "./.git/*" -exec sed -i '' -E "s|$1[^\"']*|$1?v=$2|g" {} +; }

bust "css/style.css" "${css_hash}"
bust "js/main.js"   "${js_hash}"

echo "Cache busted: style.css?v=${css_hash} main.js?v=${js_hash}"
