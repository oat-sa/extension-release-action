#!/bin/sh -l

GITHUB_TOKEN=$INPUT_GITHUB_TOKEN
MESSAGES_JSON='{"serial":"9","date":1615820392,"version":"3.3.0-9","translations":{}}'
REPO_NAME=$(jq --raw-output '."name"' composer.json)
EXT_ID=$(jq --raw-output '.extra."tao-extension-name"' composer.json)

echo "Copy auxiliary scripts"

cp /generateComposerFile.php /github/workspace/generateComposerFile.php
cp /getExitCode.php /github/workspace/getExitCode.php
cp /getOutput.php /github/workspace/getOutput.php

echo "Prepare composer file ..."

COMPOSER_GENERATION_OUTPUT=$(php generateComposerFile.php)
echo "$COMPOSER_GENERATION_OUTPUT"

composer config -g github-oauth.github.com $INPUT_GITHUB_TOKEN
COMPOSER=composer-release.json composer install --no-dev --no-interaction --prefer-source

echo "Prepare Tao to release ..."

mkdir -p taoQtiItem/views/js/mathjax/
mkdir -p tao/views/locales/en-US/
mkdir -p config/
touch taoQtiItem/views/js/mathjax/MathJax.js
touch index.php
echo $MESSAGES_JSON > tao/views/locales/en-US/messages.json
cd $EXT_ID
git config --global user.name github-actions
git config --global user.email github-actions@github.com
git config --global url."https://github.com/".insteadOf git@github.com:
git config --global url."https://".insteadOf git://
git config --global url."https://github.com/".insteadOf ssh://git@github.com/
git remote set-url origin https://${GITHUB_TOKEN}@github.com/$REPO_NAME.git
git remote set-url --push origin https://${GITHUB_TOKEN}@github.com/$REPO_NAME.git
git checkout .
cd ..
echo "Release extension $EXT_ID"

TAO_RELEASE_OUTPUT=$(taoRelease extensionRelease --extension-to-release ${EXT_ID} --no-interactive --no-write)
echo "$TAO_RELEASE_OUTPUT"

EXIT_CODE=$(php getExitCode.php $TAO_RELEASE_OUTPUT)
OUTPUT_MESSAGE=$(php getOutput.php $TAO_RELEASE_OUTPUT)

echo "::set-output name=release_result::$OUTPUT_MESSAGE"
exit $EXIT_CODE