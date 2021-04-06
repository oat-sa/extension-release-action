<?php

$releaseToolOutput = implode(' ', $argv);

if (strpos($releaseToolOutput, 'Good job!') !== false) {
    echo 'success';
} else if (strpos($releaseToolOutput, 'Nothing to release') !== false) {
    echo 'skip';
} else {
    echo 'failure';
}
