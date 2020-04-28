#ignorenext
# shellcheck shell=bash disable=2154

readonly testc=$((${#tests[@]}))

if (( testc == 0 )); then
	echo "$0: missing arguments: <file>..." >&2
	echo "$USAGE"
	exit 3
fi

if $color; then
	readonly reset_clr=$'\033[0m'
	readonly failed_clr=$'\033[01;91m'
	readonly passed_clr=$'\033[01;92m'
	readonly bullet_clr=$'\033[01;94m'
	readonly strong_clr=$'\033[01;93m'
	readonly stdout_bullet_clr=$'\033[01;94m'
	readonly stderr_bullet_clr=$'\033[01;91m'
else
	readonly reset_clr='' failed_clr='' passed_clr='' bullet_clr='' strong_clr='' \
	         stdout_bullet_clr='' stderr_bullet_clr=''
fi

declare tests_maxl=-1
for ((i = 0; i < testc; ++i)); do
	declare test="${tests[i]:1}"
	((${#test} > tests_maxl)) && tests_maxl=${#test}
done
unset -v test
readonly tests_maxl

# $1: time in nanoseconds to be formatted
_format_time() {
	awk '{printf "%.2f", $1 / 10**9}' <<< "$1"
}

# $1: string to be repeated
# $2: how many times to repeat string
_repeat() {
	local string=''
	for ((i = 0; i < $2; ++i)); do
		string+="$1"
	done
	echo -n "$string"
}

# $1: number to make absolute
_abs() {
	if [ "${1:0:1}" == - ]; then
		echo -n "${1:1}"
	else
		echo -n "$1"
	fi
}

_exec_test() {
	local test="$1"

	if [ -n "$command" ]; then
		"$command" "${command_args[@]}" "$test"
	else
		./"$test"
	fi
}

# shellcheck disable=2155
declare output="Running ${strong_clr}${testc}${reset_clr} Test$( ((testc > 1)) && printf s)..."$'\n' \
        passedc=0 failedc=0 dur=0

for ((i = 0; i < testc; ++i)); do
	declare test="${tests[i]:1}" silent=false
	if [ "${tests[i]:0:1}" == s ]; then
		silent=true
	fi

	# test number and test name
	output+=' '
	declare n=$((i + 1))
	declare n_str="${bullet_clr}${n})${reset_clr}"
	for ((j = ${#n}, l = ${#testc}; j < l; ++j)) do
		n_str="$n_str "
	done
	output+="${n_str} ${test} "
	for ((j = 0, l = (tests_maxl - ${#test}) + 10; j < l; ++j)); do
		output+='.'
	done
	output+=' '

	# saving test output and adding exit status
	# shellcheck disable=2155
	declare test_output='' test_start_time=$(date +%s%N)
	test_output+=$(_exec_test "./$test" \
	               2> >(sed -E s/'^'/"$(_repeat ' ' ${#testc}) ${stderr_bullet_clr}2>${reset_clr} "/g) \
	               1> >(sed -E s/'^'/"$(_repeat ' ' ${#testc}) ${stdout_bullet_clr}1>${reset_clr} "/g))
	# shellcheck disable=2155
	declare exc=$? test_end_time=$(date +%s%N)
	if ((exc == 0)); then
		output+="${passed_clr}Passed${reset_clr}       "
		((++passedc))
	else
		output+="${failed_clr}Failed${reset_clr} (${failed_clr}${exc}${reset_clr}) "
		output+="$(_repeat ' ' "$(_abs $((${#exc} - 3)))")"
		((++failedc))
	fi
	output+="$(_format_time $((test_end_time - test_start_time)))s"
	dur=$((dur + $((test_end_time - test_start_time))))

	# adding test output
	if ! $silent_all && ! $silent && [ -n "$test_output" ]; then
		output+=$'\n'"$test_output"
	fi

	output+=$'\n'
done

# shellcheck disable=2155
declare passedp=$(awk '{printf "%.0f", $1 / $2 * 100}' <<< "$passedc $testc") \
        failedp=$(awk '{printf "%.0f", (1 - $1 / $2) * 100}' <<< "$passedc $testc")

readonly BAR_CHAR='|'

# end message
output+=$'Done\n\n'
output+="$(_repeat ' ' $((${#failedc} - ${#passedc})))$passedc/$testc ${passed_clr}Passed${reset_clr} "
output+="$(_repeat ' ' $((${#failedp} - ${#passedp})))(${passed_clr}${passedp}%${reset_clr}) "
output+="[${passed_clr}$(_repeat "$BAR_CHAR" $((passedp / 2)))${reset_clr}$(_repeat '.' $((failedp / 2)))]"
output+=$'\n'
output+="$(_repeat ' ' $((${#passedc} - ${#failedc})))$failedc/$testc ${failed_clr}Failed${reset_clr} "
output+="$(_repeat ' ' $((${#passedp} - ${#failedp})))(${failed_clr}${failedp}%${reset_clr}) "
output+="[${failed_clr}$(_repeat "$BAR_CHAR" $((failedp / 2)))${reset_clr}$(_repeat '.' $((passedp / 2)))]"
output+=$'\n'
output+="=== Time taken: $(_format_time $dur)s ==="
# yes I know this looks like hell shut up

echo "$output"

if ((passedc == testc)); then
	exit 0
elif ((passedc > 0)); then
	exit 32
else
	exit 33
fi
