<!-- markdownlint-disable MD033 -->

# Unit Test Script #

[version_shield]: https://img.shields.io/badge/version-v1.0.2-blue.svg
[latest_release]: https://github.com/mfederczuk/utest-script/releases/latest "Latest Release"
[![version: v1.0.2][version_shield]][latest_release]
[![Changelog](https://img.shields.io/badge/-Changelog-blue.svg)](./CHANGELOG.md "Changelog")

## About ##

A **Bash** script that starts unit tests.

## Usage ##

1. `<script> ([-s] <file>)...`
2. `<script> --silent-all <file>...`

Add every *FILE* as a test.

Every test is executed and exit code, `stdout` and `stderr` output is saved and
displayed in a listed format.

### Options ###

| Option                | Description                                                                                       |
| :-------------------- | :------------------------------------------------------------------------------------------------ |
| `-s, --silent=<file>` | add *FILE* as test but don't save the output of it                                                |
| `--silent-all`        | don't save the output of any test                                                                 |
| `-c, --color=<when>`  | when to color the output (default: auto). <br/> *WHEN* may be: '`always`', '`auto`', or '`never`' |
| `-h, --help`          | show this summary and exit                                                                        |
| `-v, --version`       | show version and legal information and exit                                                       |

### Exit Status ###

(using [CommonCodes v2](https://mfederczuk.github.io/commoncodes/v2.html))

| Code |      Message      |
| :--: | :---------------: |
|   0  | all tests passed  |
|  32  | some tests failed |
|  33  | all tests failed  |

## Download ##

To get the script, simply download the attached file from one of the
[releases](https://github.com/mfederczuk/utest-script/releases).

If you want to make changes to it, download the source code or clone the
repository with

	git clone https://github.com/mfederczuk/utest-script.git

Modify the script however you like and call the [`assemble`](assemble) script.  
Make sure you have [**spp**](https://github.com/mfederczuk/spp) installed.

## Contributing ##

Read through the [Unit Test Script Contribution Guidelines](./CONTRIBUTING.md)
 if you want to contribute to this project.

## License ##

[GNU GPLv3+](./LICENSE)
