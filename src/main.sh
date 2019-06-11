#ignorenext
# shellcheck shell=bash disable=2154

readonly testc=$((${#tests[@]}))

if (( testc == 0 )); then
	echo "$0: missing arguments: <file>..." >&2
	exit 3
fi

if $color; then
	readonly reset_clr=$'\033[0m'
	readonly failed_clr=$'\033[01;91m'
	readonly passed_clr=$'\033[01;92m'
	readonly bullet_clr=$'\033[01;94m'
else
	readonly reset_clr='' failed_clr='' passed_clr='' bullet_clr=''
fi

declare tests_maxl=-1
for ((i = 0; i < testc; ++i)); do
	((${#tests[i]} > tests_maxl)) && tests_maxl=${#tests[i]}
done
readonly tests_maxl

declare output=$'Running Tests...\n' passedc=0 failedc=0

for ((i = 0; i < testc; ++i)); do
	declare test="${tests[i]}"

	output+=" $bullet_clr*$reset_clr $test "
	for ((j = 0, l = (tests_maxl - ${#test}) + 3; j < l; ++j)); do
		output+='.'
	done
	output+=' '

	"$test" &> '/dev/null'
	declare exc=$?
	if ((exc == 0)); then
		output+="${passed_clr}Passed${reset_clr}"
		((++passedc))
	else
		output+="${failed_clr}Failed${reset_clr} (${failed_clr}${exc}${reset_clr})"
		((++failedc))
	fi

	output+=$'\n'
done

output+=$'\n'
output+="$passedc/$testc ${passed_clr}Passed${reset_clr}"
output+='  |  '
output+="$failedc/$testc ${failed_clr}Failed${reset_clr}"

echo "$output"

if ((passedc == testc)); then
	exit 0
elif ((passedc != 0)); then
	exit 32
else
	exit 33
fi
