#ignorenext
# shellcheck shell=bash

check_color_support() {
	case "$TERM" in
		xterm-color|*-256color) echo true ;;
		*) echo false ;;
	esac
}

# shellcheck disable=2155
declare tests=() \
        color=$(check_color_support) \
        silent_all=false \
        command='' \
        command_args=()

option_silent() {
	if (($# < 2)); then
		echo "$0: $1: missing argument: <file>" >&2
		echo "$USAGE"
		exit 3
	fi

	tests+=("s$2")
}

option_silent_all() {
	if (($# > 1)); then
		echo "$0: $1: too many arguments: 1" >&2
		echo "$USAGE"
		exit 4
	fi

	silent_all=true
}

option_command() {
	if (($# < 2)); then
		echo "$0: $1: missing argument: <cmd>" >&2
		exit 3
	fi

	command="$2"
}

option_command_arg() {
	if (($# < 2)); then
		echo "$0: $1: missing argument: <arg>" >&2
		exit 3
	fi

	command_args+=("$2")
}

option_color() {
	if (($# < 2)); then
		echo "$0: $1: missing argument: <when>" >&2
		exit 3
	fi

	case "$opt_arg" in
		'always')
			color=true
			;;
		'auto')
			# checking if the terminal supports color
			color=$(check_color_support)
			;;
		'never')
			color=false
			;;
		*)
			echo "$0: $1: $opt_arg: invalid argument: WHEN must be: 'always', 'auto' or 'never'" >&2
			exit 7
			;;
	esac
}

option_help() {
	if (($# > 1)); then
		echo "$0: $1: too many arguments: 1" >&2
		exit 4
	fi

	echo "$HELP"
	exit 0
}

option_version_info() {
	if (($# > 1)); then
		echo "$0: $1: too many arguments: 1" >&2
		exit 4
	fi

	echo "$VERSION_INFO"
	exit 0
}

declare ignore_opts=false argv=("$@")
for ((i = 0, s = $#; i < s; ++i)); do
	declare arg="${argv[i]}"

	if ! $ignore_opts && [[ "$arg" =~ ^--$ ]]; then
		ignore_opts=true
	elif ! $ignore_opts && [[ "$arg" =~ ^--([^=]+)(=.*)?$ ]]; then
		declare opt="${BASH_REMATCH[1]}"

		declare has_arg=false
		declare opt_arg
		if [[ "${BASH_REMATCH[2]}" =~ ^=(.*)$ ]]; then
			has_arg=true
			opt_arg="${BASH_REMATCH[1]}"
		fi

		case "$opt" in
			'silent')
				if $has_arg; then
					option_silent "--$opt" "$opt_arg"
				elif ((i + 1 < s)); then
					((++i))
					opt_arg="${argv[i]}"
					option_silent "--$opt" "$opt_arg"
				else
					option_silent "--$opt"
				fi
				;;
			'silent-all')
				if $has_arg; then
					option_silent_all "--$opt" "$opt_arg"
				else
					option_silent_all "--$opt"
				fi
				;;
			'color')
				if $has_arg; then
					option_color "--$opt" "$opt_arg"
				elif ((i + 1 < s)); then
					((++i))
					opt_arg="${argv[i]}"
					option_color "--$opt" "$opt_arg"
				else
					option_color "--$opt"
				fi
				;;
			'command')
				if $has_arg; then
					option_command "--$opt" "$opt_arg"
				elif ((i + 1 < s)); then
					((++i))
					opt_arg="${argv[i]}"
					option_command "--$opt" "$opt_arg"
				else
					option_command "--$opt"
				fi
				;;
			'command-arg')
				if $has_arg; then
					option_command_arg "--$opt" "$opt_arg"
				elif ((i + 1 < s)); then
					((++i))
					opt_arg="${argv[i]}"
					option_command_arg "--$opt" "$opt_arg"
				else
					option_command_arg "--$opt"
				fi
				;;
			'help')
				if $has_arg; then
					option_help "--$opt" "$opt_arg"
				else
					option_help "--$opt"
				fi
				;;
			'version')
				if $has_arg; then
					option_version_info "--$opt" "$opt_arg"
				else
					option_version_info "--$opt"
				fi
				;;
			*)
				echo "$0: --$opt: invalid option" >&2
				echo "$USAGE"
				exit 5
				;;
		esac

		unset -v opt_arg has_arg opt
	elif ! $ignore_opts && [[ "$arg" =~ ^-([^-].*)$ ]]; then
		declare optstr="${BASH_REMATCH[1]}"

		for ((j = 0, l = ${#optstr}; j < l; ++j)); do
			declare opt="${optstr:0:1}"
			optstr="${optstr:1}"

			declare opt_arg

			case "$opt" in
				's')
					if [ -n "$optstr" ]; then
						j=l
						opt_arg="$optstr"
						option_silent "-$opt" "$opt_arg"
					elif ((i + 1 < s)); then
						((++i))
						opt_arg="${argv[i]}"
						option_silent "-$opt" "$opt_arg"
					else
						option_silent "-$opt"
					fi
					;;
				'c')
					if [ -n "$optstr" ]; then
						j=l
						opt_arg="$optstr"
						option_color "-$opt" "$opt_arg"
					elif ((i + 1 < s)); then
						((++i))
						opt_arg="${argv[i]}"
						option_color "-$opt" "$opt_arg"
					else
						option_color "-$opt"
					fi
					;;
				'm')
					if [ -n "$optstr" ]; then
						j=l
						opt_arg="$optstr"
						option_command "-$opt" "$opt_arg"
					elif ((i + 1 < s)); then
						((++i))
						opt_arg="${argv[i]}"
						option_command "-$opt" "$opt_arg"
					else
						option_command "-$opt"
					fi
					;;
				'A')
					if [ -n "$optstr" ]; then
						j=l
						opt_arg="$optstr"
						option_command_arg "-$opt" "$opt_arg"
					elif ((i + 1 < s)); then
						((++i))
						opt_arg="${argv[i]}"
						option_command_arg "-$opt" "$opt_arg"
					else
						option_command_arg "-$opt"
					fi
					;;
				'h'|'?')
					option_help "-$opt"
					;;
				'V'|'v')
					option_version_info "-$opt"
					;;
				*)
					echo "$0: -$opt: invalid option" >&2
					echo "$USAGE"
					exit 5
					;;
			esac

			unset -v opt_arg opt
		done

		unset -v optstr
	else
		tests+=("-$arg")
	fi

	unset -v arg
done; unset -v i s
unset -v argv ignore_opts

readonly tests color silent_all command command_args
