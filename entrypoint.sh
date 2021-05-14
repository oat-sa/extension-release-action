#!/bin/sh -l

GITHUB_TOKEN=$INPUT_GITHUB_TOKEN
NPM_TOKEN=$INPUT_NPM_TOKEN

MESSAGES_JSON='{"serial":"9","date":1615820392,"version":"3.3.0-9","translations":{}}'
REPO_NAME=$(jq --raw-output '."name"' composer.json)
EXT_ID=$(jq --raw-output '.extra."tao-extension-name"' composer.json)

echo "Copy auxiliary scripts"

cp /generateComposerFile.php /github/workspace/generateComposerFile.php
cp /getExitCode.php /github/workspace/getExitCode.php
cp /getOutput.php /github/workspace/getOutput.php

echo "Prepare NPM ..."
npm config set //registry.npmjs.org/:_authToken=${NPM_TOKEN}
echo "//registry.npmjs.org/:_authToken=${NPM_TOKEN}" > ~/.npmrc
cat ~/.npmrc

exit 1
