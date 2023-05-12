# Container image that runs your code
FROM taotesting/tao-release:latest

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh
COPY generateComposerFile.php /generateComposerFile.php
COPY getExitCode.php /getExitCode.php
COPY getOutput.php /getOutput.php

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
