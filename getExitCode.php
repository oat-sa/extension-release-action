<?php

$releaseToolOutput = implode(' ', $argv);

if (strpos($releaseToolOutput, 'Good job!') !== false) {
    echo '0';
} else if (strpos($releaseToolOutput, 'Nothing to release') !== false) {
    echo '0';
} else {
    echo '1';
}