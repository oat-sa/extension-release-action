#!/bin/sh -l

GITHUB_TOKEN=$INPUT_GITHUB_TOKEN

php -r '$composerArray = json_decode(file_get_contents("./composer.json"), true);
  $composerArray["require"][$composerArray["name"]] = "dev-develop";
  $composerArray["repositories"] = is_array($composerArray["repositories"]) ? $composerArray["repositories"] : [];
  $composerArray["repositories"][] = [
    "type" => "vcs",
    "url" => "https://github.com/".$composerArray["name"].".git"
  ];
  unset($composerArray["name"]);
  file_put_contents("./composer-release.json", json_encode($composerArray, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES));'

composer config -g github-oauth.github.com $INPUT_GITHUB_TOKEN

COMPOSER=composer-release.json composer install --no-dev --no-interaction --prefer-source

echo "Prepare Tao to release"

mkdir -p taoQtiItem/views/js/mathjax/
touch taoQtiItem/views/js/mathjax/MathJax.js
mkdir -p tao/views/locales/en-US/
echo '{"serial":"9","date":1615820392,"version":"3.3.0-9","translations":{}}' > tao/views/locales/en-US/messages.json
touch index.php
mkdir -p config/

REPO_NAME=$(jq --raw-output '."name"' composer.json)
EXT_ID=$(jq --raw-output '.extra."tao-extension-name"' composer.json)

echo "Release extension $EXT_ID"

cd $EXT_ID
git config --global user.name github-actions
git config --global user.email github-actions@github.com
git remote set-url --push origin https://${GITHUB_TOKEN}@github.com/$REPO_NAME.git
cd ..
taoRelease extensionRelease --extension-to-release ${EXT_ID} --no-interactive --no-write
