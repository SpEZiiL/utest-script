# Unit Test Script #

![status][status-img] [![version][version-img]][version-link]

## About ##

A **Bash** script that starts unit tests.

## How To Use ##

### Usage ###

`<script> <file>...`

Add every FILE as a test.

### Description ###

Every test is executed and exit code, `stdout` and `stderr` output is saved and
displayed in a listed format.

### Options ###

| Option                | Description |
| :-------------------- | :---------- |
| `-s, --silent=<file>` | add FILE as test but don't save the output of it |
| `--silent-all`        | don't save the output of any test |
| `-c, --color=<when>`  | when to color the output (default: auto) WHEN may be: 'always', 'auto', or 'never' |
| `-h, --help`          | show this summary and exit |
| `-v, --version`       | show version and legal information and exit |

### Exit Status ###

(using [CommonCodes v1.0.0](https://speziil.github.io/commoncodes/v/1.0.0.html))

| Code | Message           |
| :--- | :---------------- |
| 0    | all tests passed  |
| 32   | some tests failed |
| 33   | all tests failed  |

## Downloading ##

To get the script, simply download the attached file from one of the
[releases](https://github.com/SpEZiiL/utest-script/releases).

If you want to make changes to it, download the source code or clone the
repository with `git clone https://github.com/SpEZiiL/utest-script.git`.  
Modify the script however you like and call the [`assemble.sh`](assemble.sh)
script.  
Make sure you have [**spp**](https://github.com/SpEZiiL/spp) installed.

<!-- Shields -->

[status-img]: https://img.shields.io/badge/dynamic/json.svg?label=status&url=http%3A%2F%2Fspeziil.ddns.net%2Frepos%2Futest-script.json&query=%24.status&colorB=brightgreen
[version-img]: https://img.shields.io/badge/dynamic/json.svg?label=version&url=http%3A%2F%2Fspeziil.ddns.net%2Frepos%2Futest-script.json&query=%24.version&colorB=blue
[version-link]: https://github.com/SpEZiiL/utest-script/releases/latest "Latest version"
