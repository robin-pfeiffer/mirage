export MIRAGE_ESCAPE_CHARACTER_BEGIN="%{"
export MIRAGE_ESCAPE_CHARACTER_END="%}"
MIRAGE_DIR="$(dirname "${(%):-%N}")"

precmd() {
    PROMPT="$("$MIRAGE_DIR/mirage.sh" "$?")"
}