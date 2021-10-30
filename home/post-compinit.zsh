autoload -Uz promptinit
promptinit
# zsh-mime-setup
autoload colors
colors
autoload -Uz zmv # move function
autoload -Uz zed # edit functions within zle
zle_highlight=(isearch:underline)

# Turn off beep
unsetopt BEEP

# Enable nix
if [ -f ~/.nix-profile/etc/profile.d/nix.sh ]; then
	source ~/.nix-profile/etc/profile.d/nix.sh
fi

# Get dircolors
eval $(dircolors ~/.nix-profile/share/LS_COLORS)

# Powerlevel 10k
if [ -f ~/.p10k.zsh ]; then
	source ~/.p10k.zsh
fi

# .. autocompletes to ../
zstyle ':completion:*' special-dirs true

# Up/down arrow search using already entered chars
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# Autocomplete uses ls-colors
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
