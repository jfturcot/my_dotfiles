# ~/.zshrc — plain zsh, no oh-my-zsh framework.

# Source the first of the candidate files that exists (handles Arch vs Homebrew paths).
_src() { local p; for p in "$@"; do [[ -r $p ]] && { source "$p"; return 0; }; done; return 1 }

# --- powerlevel10k theme ---
_src /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme \
     "$(brew --prefix 2>/dev/null)/share/powerlevel10k/powerlevel10k.zsh-theme"

# --- completion ---
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'   # case-insensitive
zstyle ':completion:*' menu select

# --- history ---
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt share_history hist_ignore_dups hist_ignore_space hist_find_no_dups

# --- vi mode (p10k draws the mode indicator) ---
bindkey -v

# --- plugins ---
_src /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh \
     "$(brew --prefix 2>/dev/null)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# syntax highlighting must be sourced BEFORE history-substring-search (and after autosuggestions)
_src /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
     "$(brew --prefix 2>/dev/null)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# fuzzy history: type any part of a command, press Up/Down to cycle matching history entries
_src /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh \
     "$(brew --prefix 2>/dev/null)/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
bindkey '^[[A' history-substring-search-up      # Up arrow
bindkey '^[[B' history-substring-search-down    # Down arrow
zmodload -i zsh/terminfo 2>/dev/null
[[ -n "$terminfo[kcuu1]" ]] && bindkey "$terminfo[kcuu1]" history-substring-search-up
[[ -n "$terminfo[kcud1]" ]] && bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# --- p10k config ---
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# --- personal config ---
source ~/.dotfiles/zsh/env
source ~/.dotfiles/zsh/env_secure # Not in the repository, keep this secure
source ~/.dotfiles/zsh/aliases
source ~/.dotfiles/zsh/config
