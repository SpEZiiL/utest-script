#ignorenext
# shellcheck shell=bash

declare files=()

declare ignore_opts=false
for arg in "$@"; do
	if ! $ignore_opts && [[ "$arg" =~ ^--$ ]]; then
		ignore_opts=true
	elif ! $ignore_opts && [[ "$arg" =~ ^--([^=]+)(=.*)?$ ]]; then
		declare opt="${BASH_REMATCH[1]}"

		if [[ "${BASH_REMATCH[2]}" =~ ^=(.*)$ ]]; then
			declare opt_arg="${BASH_REMATCH[1]}"
		fi

		case "$opt" in
		help)
			if [ ${opt_arg+x} ]; then
				echo "$0: --help: too many arguments: 1" >&2
				exit 4
			fi
			echo "$USAGE"
			exit 0
			;;
		version)
			if [ ${opt_arg+x} ]; then
				echo "$0: --version: too many arguments: 1" >&2
				exit 4
			fi
			echo "$VERSION_INFO"
			exit 0
			;;
		*)
			echo "$0: --$opt: invalid option" >&2
			exit 5
			;;
		esac

		unset -v opt_arg
	elif ! $ignore_opts && [[ "$arg" =~ ^-([^-].*)$ ]]; then
		declare optstr="${BASH_REMATCH[1]}"

		for ((j = 0, l = ${#optstr}; j < l; ++j)); do
			declare opt="${optstr:0:1}"
			optstr="${optstr:1}"

			if [[ "${optstr:0:1}" == '-' ]]; then
				declare opt_arg="${optstr}"
			fi

			case "$opt" in
			h|\?)
				if [ ${opt_arg+x} ]; then
					echo "$0: -h: too many arguments: 1" >&2
					exit 4
				fi
				echo "$USAGE"
				exit 0
				;;
			v)
				if [ ${opt_arg+x} ]; then
					echo "$0: -v: too many arguments: 1" >&2
					exit 4
				fi
				echo "$VERSION_INFO"
				exit 0
				;;
			*)
				echo "$0: -$opt: invalid option" >&2
				exit 5
				;;
			esac

			unset -v opt_arg
		done
	else
		files+=("$arg")
	fi
done
unset -v ignore_opts arg opt optstr j l

readonly files
