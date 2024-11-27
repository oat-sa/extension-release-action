# Container image that runs your code
FROM europe-west1-docker.pkg.dev/tao-artefacts/base-images/php-v8.3-tao-release:latest

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh
COPY generateComposerFile.php /generateComposerFile.php
COPY getExitCode.php /getExitCode.php
COPY getOutput.php /getOutput.php

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
