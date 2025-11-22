1. install deps
pnpm install --frozen-lockfile
bundle install

2. build frontend assets
pnpm run build

3. build the Jekyll site with CI config
bundle exec jekyll build --trace --config _config.yml,_config.ci.yml

4. internal link/HTML check
bundle exec htmlproofer ./_site --assume-extension --check-html --disable-external --no-enforce-https

5. markdown lint (same glob as CI)
npx markdownlint-cli2 . --config .markdownlint-cli2.yaml

6. external link check (same args as CI)
lychee \
  --accept 200,206,429 \
  --max-redirects 5 \
  --timeout 20 \
  --verbose \
  --exclude "^https?://dennis\\.kim" \
  --exclude ""^https?://www\\.linkedin\\.com.*"" \
  **/*.md _site/**/*.html

7. run build-mobile-preview.sh
