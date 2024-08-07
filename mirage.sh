# shellcheck shell=sh

exit_code="$1"

# Settings

MIRAGE_ESCAPE_CHARACTER_BEGIN=${MIRAGE_ESCAPE_CHARACTER_BEGIN:-'\['}
MIRAGE_ESCAPE_CHARACTER_END=${MIRAGE_ESCAPE_CHARACTER_END:-'\]'}
MIRAGE_SHOW_SUDO=${MIRAGE_SHOW_SUDO:-true}

MIRAGE_SEGMENTS=${MIRAGE_SEGMENTS:-"exit_code user host dir scm"}

# Colour definitions

_mirage_escape() {
	printf "%b" "$MIRAGE_ESCAPE_CHARACTER_BEGIN$1$MIRAGE_ESCAPE_CHARACTER_END"
}

black=$(_mirage_escape "\033[0;30m")
red=$(_mirage_escape "\033[0;31m")
green=$(_mirage_escape "\033[0;32m")
yellow=$(_mirage_escape "\033[0;33m")
blue=$(_mirage_escape "\033[0;34m")
purple=$(_mirage_escape "\033[0;35m")
cyan=$(_mirage_escape "\033[0;36m")
white=$(_mirage_escape "\033[0;37m")
normal=$(_mirage_escape "\033[0m")
reset_color=$(_mirage_escape "\033[39m")

# Helper functions

_mirage_git_branch() {
	git symbolic-ref -q --short HEAD 2> /dev/null || return 1
}

_mirage_git_status() {
	git status --porcelain 2> /dev/null
}

_mirage_normalize() {
	printf "%b" "$normal"
}

# Prompt segments

_mirage_exit_code() {
	[ "$exit_code" -ne 0 ] && color=$red || color=$green

	printf "%b%s " "$color" "❯"
}

_mirage_user() {
	color=$blue

	# Shows if sudo has a timestamp file (sudo has been used in this session and is still valid)
	# reset: sudo -k
	("$MIRAGE_SHOW_SUDO") && sudo -vn 1> /dev/null 2>&1 && color=$red

	printf "%b%s " "$color" "$(whoami)"
}

_mirage_host() {
	printf "at %b%s " "$purple" "$(hostname)"
}

_mirage_dir() {
	[ "$PWD" = "$HOME" ] && dir="~" || dir="$(basename "$PWD")"

	printf "in %b%s " "$cyan" "$dir"
}

_mirage_scm() {
	branch="$(_mirage_git_branch)"
	[ -z "$branch" ] && return 0

	status='✓'
	status_color=$green
	[ -n "$(_mirage_git_status | tail -n1)" ] && status='±' && status_color=$yellow

	printf "on %b%s %b%s " "$blue" "$branch" "$status_color" "$status"
}

# Prompt

_mirage_build_segments() {
	for segment in $MIRAGE_SEGMENTS; do
		_mirage_normalize
		_mirage_"$segment"
		_mirage_normalize
	done
}

_mirage_ps1() {
	_mirage_build_segments
}

_mirage() {
	_mirage_ps1	
}

_mirage
