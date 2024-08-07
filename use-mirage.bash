MIRAGE_DIR="${BASH_SOURCE%/*}"

# shellcheck source=./vendor/github.com/rcaloras/bash-preexec/bash-preexec.sh
source "$MIRAGE_DIR/vendor/github.com/rcaloras/bash-preexec/bash-preexec.sh"

precmd() {
    PS1="$("$MIRAGE_DIR/mirage.sh" "$?")";
}
