#ignorenext
# shellcheck shell=bash
readonly USAGE="\
usage: $0 <file>...
    Add every FILE as a test.

    Every test is executed and exit code, stdout and stderr output is saved and
    displayed in a listed format.

    Options:
      -s, --silent=<file>  add FILE as test but don't save the output of it
          --silent-all     don't save the output of any test
      -c, --color=<when>   when to color the output (default: auto).
                            WHEN may be: 'always', 'auto', or 'never'
      -h, --help           show this summary and exit
      -v, --version        show version and legal information and exit

    Exit Status:
      (using CommonCodes v1.0.0
       <https://mfederczuk.github.io/commoncodes/v/1.0.0.html>)
      0   all tests passed
      32  some tests failed
      33  all tests failed

Report bugs at: <$REPO_URL>"
