#ignorenext
# shellcheck shell=bash
readonly USAGE="\
usage: $0 <file>...
    Calls every FILE.

    Options:
      -c, --color=<when>  when to color the output (default: auto)
                           WHEN may be: 'always', 'auto', or 'never'
      -h, --help          show this summary and exit
      -v, --version       show version and legal information and exit

    Exit Status:
      (using CommonCodes v1.0.0
          <https://speziil.github.io/commoncodes/v/1.0.0.html>)
      0   all tests passed
      32  some tests failed
      33  all tests failed

Report bugs to: <$MAILING_ADDRESS>
Repository: <$REPO_URL>"
