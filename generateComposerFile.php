<?php

$composerArray = json_decode(file_get_contents('./composer.json'), true);
$packageName = $composerArray["name"];
$composerArray["require"][$packageName] = 'dev-develop as v99.99.99';
$composerArray["repositories"] = array_key_exists("repositories", $composerArray) ? $composerArray["repositories"] : [];
$composerArray["repositories"][] = [
    "type" => "vcs",
    "url" => "https://github.com/".$composerArray["name"].".git"
];
unset($composerArray['name']);
file_put_contents('./composer-release.json', json_encode($composerArray, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES));

echo 'Composer file successfully generated: ' . PHP_EOL . file_get_contents('./composer-release.json');
