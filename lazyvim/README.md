# LazyVim customizations

These files extend the existing LazyVim installation in `~/.config/nvim`.
The separate `../nvim` directory contains the older Kickstart configuration.

Install the links (also handled by `../setup` when LazyVim is installed):

```sh
mkdir -p ~/.config/nvim/lua/plugins
ln -sfn ~/.dotfiles/lazyvim/lua/plugins/markdownlint.lua ~/.config/nvim/lua/plugins/markdownlint.lua
ln -sfn ~/.dotfiles/lazyvim/lua/plugins/session.lua ~/.config/nvim/lua/plugins/session.lua
ln -sfn ~/.dotfiles/lazyvim/markdownlint-cli2.jsonc ~/.config/nvim/markdownlint-cli2.jsonc
```

Restart Neovim after installing. Edit `markdownlint-cli2.jsonc` to disable
additional rules by setting their IDs to `false` in `config`.
MD013 (line length) is disabled for both linting and formatting; other rules
retain their defaults. Project-specific markdownlint configuration can override
these base settings.

Launching `nvim` without arguments restores the saved session for the current
directory (and Git branch), including open file buffers and window layout.
If no session exists, the usual dashboard remains. Opening a file explicitly,
reading piped input, or loading a session with `-S` skips automatic restoration.
LazyVim saves sessions on exit; save file edits before quitting as usual.
