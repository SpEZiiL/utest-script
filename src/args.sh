#ignorenext
# shellcheck shell=bash

# shellcheck disable=2155
declare tests=() color=$([[ "$TERM" =~ (^xterm-color$)|(-256color$) ]] &&
                         echo true || echo false)

declare ignore_opts=false argv=("$@")
for ((i = 0, s = $#; i < s; ++i)); do
	declare arg="${argv[i]}"

	if ! $ignore_opts && [[ "$arg" =~ ^--$ ]]; then
		ignore_opts=true
	elif ! $ignore_opts && [[ "$arg" =~ ^--([^=]+)(=.*)?$ ]]; then
		declare opt="${BASH_REMATCH[1]}"

		if [[ "${BASH_REMATCH[2]}" =~ ^=(.*)$ ]]; then
			declare opt_arg="${BASH_REMATCH[1]}"
		fi

		case "$opt" in
		color)
			if ! [ ${opt_arg+x} ]; then
				if ((i + 1 < s)); then
					((++i))
					opt_arg="${argv[i]}"
				else
					echo "$0: --color: missing argument: <when>"
					exit 3
				fi
			fi

			case "$opt_arg" in
			'always') color=true ;;
			'auto')
				# checking if the terminal supports color
				case "$TERM" in
				xterm-color|*-256color) color=true ;;
				*) color=false ;;
				esac
				;;
			'never') color=false ;;
			*)
				echo "$0: --color: $opt_arg: invalid argument: WHEN may only be: 'always', 'auto' or 'never'" >&2
				exit 7
				;;
			esac
			;;
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
			c)
				if ! [ ${opt_arg+x} ]; then
					if [ "$optstr" ]; then
						opt_arg="$optstr"
						j=l
					elif ((i + 1 < s)); then
						((++i))
						opt_arg="${argv[i]}"
					else
						echo "$0: -c: missing argument: <when>"
						exit 3
					fi
				fi

				case "$opt_arg" in
				'always') color=true ;;
				'auto')
					# checking if the terminal supports color
					case "$TERM" in
					xterm-color|*-256color) color=true ;;
					*) color=false ;;
					esac
					;;
				'never') color=false ;;
				*)
					echo "$0: --color: $opt_arg: invalid argument: WHEN may only be: 'always', 'auto' or 'never'" >&2
					exit 7
					;;
				esac
				;;
			*)
				echo "$0: -$opt: invalid option" >&2
				exit 5
				;;
			esac

			unset -v opt_arg
		done
	else
		tests+=("$arg")
	fi
done
unset -v ignore_opts argv i s arg opt optstr j l

readonly tests color
