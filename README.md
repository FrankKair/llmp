# llmp

A small, version-controlled library of reusable LLM interaction protocols,
with an `fzf`-based command-line picker.

The idea is simple: **prompt-engineer the interaction protocol, not the
intelligence.**

Prompts define reusable rules of engagement -- how an AI should review, teach,
question, debug, or collaborate. Task-specific context stays in the
conversation.

Prompts are plain `.txt` files: explicit, editable, composable, and
version-controlled. No prompt framework, templating system, or hidden state.

## Requirements

- Bash
- `fzf`
- `pbcopy` (macOS), `wl-copy` (Wayland), or `xclip` / `xsel` (X11)

## Install

Clone the repository, then run:

```
./install.sh
```

This creates a symlink at `~/.local/bin/llmp`. Make sure `~/.local/bin` is on
your `PATH`.

## Usage

Run:

```
llmp
```

Select a prompt with `fzf`. A preview is shown alongside the list; press
`Enter` to copy the selected prompt to the clipboard.

Prompts can live anywhere under `prompts/`:

```
prompts/
├── bug-hunter.txt
├── codebase-explorer.txt
├── commit.txt
├── disciplined-coding.txt
├── tutorial/
│   ├── language.txt
│   ├── cs-tutorial.txt
│   └── interview.txt
└── ...
```

Add or edit a `.txt` file and it is immediately available the next time
`llmp` runs.

To use a different prompt directory:

```
LLMP_DIR="$HOME/path/to/prompts" llmp
```

## Uninstall

```
./uninstall.sh
```

This removes the `~/.local/bin/llmp` symlink, not the repository or prompts.

## License

MIT
