# ----------------------------
# Zsh Completion Configuration
# ----------------------------

# Load the Zsh completion system
autoload -U compinit
compinit

# ----------------------------
# Define completers order
# ----------------------------
# _extensions: completes file extensions
# _complete: normal completion
# _approximate: fuzzy completion if no exact match
zstyle ':completion:*' completer _extensions _complete _approximate

# ----------------------------
# Enable caching
# ----------------------------
mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"  # ensure cache directory exists
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/.zcompcache"

# ----------------------------
# Menu selection and formatting
# ----------------------------
zstyle ':completion:*' menu select      # interactive menu if too many matches
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'

# ----------------------------
# Completion Matching Control
# ----------------------------
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'


if [[ -z $DISPLAY ]] && [[ $(tty) == /dev/tty1 ]]; then
	exec start-hyprland
fi

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
