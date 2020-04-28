#ignorenext
# shellcheck shell=bash
#ignorenext
# change these variables however you need
readonly PROGRAM="utest-script"
readonly VERSION_MAJOR=$((1)) VERSION_MINOR=$((0)) VERSION_PATCH=$((2))
readonly COPYRIGHT_YEARS=('2019' '2020') COPYRIGHT_HOLDER='Michael Federczuk'
readonly LICENSE='GPLv3+' LICENSE_DESC='GNU GPL version 3 or later' \
         LICENSE_URL='https://gnu.org/licenses/gpl.html'
readonly AUTHORS=('Michael Federczuk')
readonly MAILING_ADDRESS='federczuk.michael@protonmail.com'
readonly REPO_URL='https://github.com/mfederczuk/utest-script'

#ignorenext
# don't change these variables!
readonly VERSION="$VERSION_MAJOR.$VERSION_MINOR.$VERSION_PATCH"
readonly COPYRIGHT_YEAR_LATEST="${COPYRIGHT_YEARS[${#COPYRIGHT_YEARS[@]} - 1]}"
AUTHORS_LIST="${AUTHORS[0]}"
for (( i = 1, s = ${#AUTHORS[@]} - 1; i < s; ++i )); do
	AUTHORS_LIST+=", ${AUTHORS[i]}"
done
unset -v i s
if (( ${#AUTHORS[@]} > 1 )); then
	AUTHORS_LIST+=" and ${AUTHORS[-1]}"
fi
readonly AUTHORS_LIST

#include usage.bash

#include help.bash

#include version-info.bash
