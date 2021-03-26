# Container image that runs your code
FROM goodnickoff/taorelease:0.0.7

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh
COPY generateComposerFile.php /github/workspace/generateComposerFile.php
COPY getExitCode.php /github/workspace/getExitCode.php
COPY getOutput.php /github/workspace/getOutput.php

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]