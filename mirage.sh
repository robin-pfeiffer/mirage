# shellcheck shell=sh

# Settings

MIRAGE_SHOW_SUDO=${MIRAGE_SHOW_SUDO:-true}

MIRAGE_SEGMENTS=${MIRAGE_SEGMENTS:-"exit_code user host dir scm"}

# Colour definitions

black="\[\033[0;30m\]"
red="\[\033[0;31m\]"
green="\[\033[0;32m\]"
yellow="\[\033[0;33m\]"
blue="\[\033[0;34m\]"
purple="\[\033[0;35m\]"
cyan="\[\033[0;36m\]"
white="\[\033[0;37m\]"
normal="\[\033[0m\]"
reset_color="\[\033[39m\]"

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
	exit_code="$?"
	PS1="$(_mirage_ps1)"
}
