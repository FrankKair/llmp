# llmp

A small, version-controlled prompt library with a `fzf`-based command-line
picker.

Prompts are plain `.txt` files stored under `prompts/`. Select a prompt with
`fzf`, preview it, and copy it to the system clipboard.

```
                         Git repository
                               │
                               ▼
                       ~/Documents/llmp
                 ┌────────────────────────┐
                 │ llmp                   │
                 │ install.sh             │
                 │ uninstall.sh           │
                 │ prompts/               │
                 │   coding/              │
                 │   writing/             │
                 │   ...                  │
                 └───────────┬────────────┘
                             │
                         real path
                             │
                             ▼
                    ~/.local/bin/llmp
                         symlink
                             │
                             ▼
                         llmp command
                             │
                             ▼
                       prompts/*.txt
```

The installed command is a symlink. It resolves the repository containing the
executable, so the repository can remain wherever it was cloned.

## Requirements

- Bash
- `fzf`
- One supported clipboard command:
  - macOS: `pbcopy`
  - Wayland: `wl-copy`
  - X11: `xclip` or `xsel`

## Installation

From the repository:

```
./install.sh
```

The installer creates:

```
~/.local/bin/llmp -> /path/to/llmp/llmp
```

If `~/.local/bin` is not on your `PATH`, add it to your shell configuration:

```
export PATH="$HOME/.local/bin:$PATH"
```

Then reload your shell and run:

```
llmp
```

The installer refuses to overwrite an existing path.

## Usage

Run:

```
llmp
```

Use `fzf` to select a prompt:

- Prompt paths are shown relative to `prompts/`;
- The preview pane displays the selected file;
- Press `Enter` to copy it;
- Press `Esc` to cancel.

Only files ending in `.txt` are included.

## Adding prompts

Create a `.txt` file anywhere under `prompts/`:

```
mkdir -p prompts/coding
$EDITOR prompts/coding/review.txt
```

It will be available the next time you run:

```
llmp
```

Example layout:

```
prompts/
├── coding/
│   ├── review.txt
│   └── explain.txt
├── writing/
│   ├── edit.txt
│   └── summarize.txt
└── research/
    └── analyze.txt
```

## Custom prompt directory

Use another prompt collection without changing the repository:

```
LLMP_DIR="$HOME/path/to/prompts" llmp
```

The directory must contain `.txt` files.

## Uninstallation

From the repository:

```
./uninstall.sh
```

This removes only the symlink created by `install.sh`.

It does not remove:

- the repository
- prompt files
- Git history
- the `~/.local/bin` directory
- pre-existing files or symlinks

## Troubleshooting

### `llmp: command not found`

Add the installation directory to `PATH`:

```
export PATH="$HOME/.local/bin:$PATH"
```

Then reload your shell.

### `fzf` is missing

Install `fzf` using your system's package manager.

### No clipboard command is available

Install one of the supported clipboard utilities:

- macOS: `pbcopy` is included with the system.
- Wayland: install `wl-copy`, usually provided by `wl-clipboard`.
- X11: install `xclip` or `xsel`.

### No prompts are found

Make sure the prompt directory exists and contains `.txt` files:

```
find prompts -type f -name '*.txt'
```

You can also specify another directory:

```
LLMP_DIR="$HOME/path/to/prompts" llmp
```

### The command is not executable

Make the scripts executable:

```
chmod +x llmp install.sh uninstall.sh
```

## License

MIT License. See [LICENSE](LICENSE).
