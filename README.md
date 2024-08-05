# Mirage

A simple shell theme

## Features

- Exit code visualization
- User with sudo validitity visualization
- Host
- Current directory
- Git branch and changes

## Installation

Clone this repository to your desired location with `git clone --depth=1 https://github.com/robin-pfeiffer/mirage.git ~/Projects/github/robin-pfeiffer/mirage`.

Depending on your shell, source `mirage.sh`, from the location you cloned the repository into, in your `.*rc` file (e.g. `.bashrc`, `.zshrc`) and execute the `_mirage` function to alter `PS1`:

```sh
# .bashrc
source "$HOME/Projects/robin-pfeiffer/mirage/mirage.sh"
PROMPT_COMMAND=_mirage

# .zshrc
source "$HOME/Projects/robin-pfeiffer/mirage/mirage.sh"
precmd() { _mirage; }
```

Apply the changes by sourcing your `.*rc` file.

### Configuration

Mirage provides basic configuration of certain features and prompt build-up.

#### `MIRAGE_SHOW_SUDO`

> `true` or `false`, default: `true`

When `true` shows the validity of `sudo` for the current session by colouring the user red instead of blue.

#### `MIRAGE_SEGMENTS`

> Segmented string, default: `"exit_code user host dir scm"`

Add or remove segments from the prompt being used.

## Updating

Pull the latest changes from this repository with `git pull --ff-only`, and source your shell's `.*rc` file to apply the changes.

## Development

Shell files in this respository are validated with ShellCheck. After making changes to any shell files, run ShellCheck to validate these changes. See [ShellCheck](https://github.com/koalaman/shellcheck/blob/master/README.md) for information about installation and usage.

When making changes to the prompt, _always_ make sure that the combination of default segments results in a logical English sentence.

## License

Distributed under MIT License. See [LICENSE](./LICENSE) for more information.
