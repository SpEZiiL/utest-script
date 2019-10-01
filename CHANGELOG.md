<!-- markdownlint-disable MD024 -->

# Changelog #

All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [v1.0.1] - 2019-06-22 ##

### Fixed ###

* Added a `./` prefix to the files being executed so that tests that are in the
  same directory would not be mistaken for normal commands in one of the `PATH`
  directories

[v1.0.1]: https://github.com/mfederczuk/utest-script/compare/v1.0.0...v1.0.1

## [v1.0.0] - 2019-06-14 ##

### Added ###

* Amount of tests is shown at the beginning
* `stdout` and `stderr` of test output is saved and outputted
  * New options `--silent=<file>` and `--silent-all` to disable output for tests
* Duration of each test is displayed
* Added end message
  * Displays how many tests passed and how many failed
    * Also shows percentage and graphical bar, making it easier to see the ratio
      of passed to failed tests
  * Displays the time taken for all tests in total (all durations of each test
    is added together)

[v1.0.0]: https://github.com/mfederczuk/utest-script/compare/v0.1.0...v1.0.0

## [v0.1.0] - 2019-06-10 ##

### Added ###

* Added base script

[v0.1.0]: https://github.com/mfederczuk/utest-script/releases/tag/v0.1.0
