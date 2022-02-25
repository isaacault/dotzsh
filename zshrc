# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.zsh/external/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Include completions
fpath=(/home/isaac/.zsh/external/zsh-completions/src  $fpath)

# Zsh settings for history
HISTORY_IGNORE="(ls|[bf]g|exit|reset|clear|cd|cd ..|cd..)"
HISTSIZE=25000
HISTFILE=~/.zsh/zsh_history
SAVEHIST=100000
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY


# Enable color support of ls
if [[ "$TERM" != "dumb" ]]; then
    if [[ -x `which dircolors 2> /dev/null` ]]; then
        eval `dircolors -b`
        if ls --color &> /dev/null; then
            alias 'ls=ls --color=auto'
        fi
    fi
fi

##############################################################################
# The following lines were added by compinstall
zstyle ':completion:*' completer _complete _match
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' glob 0
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list '+m:{a-z}={A-Z} r:|[._-]=** r:|=**' '' '' '+m:{a-z}={A-Z} r:|[._-]=** r:|=**'
zstyle ':completion:*' max-errors 1 numeric
zstyle ':completion:*' substitute 0
zstyle :compinstall filename "$HOME/.zshrc"
# End of lines added by compinstall

# Completers for my own scripts
zstyle ':completion:*:*:(album-cover|copy-geotag):*' file-patterns '*.(#i)(jp*g|png|tif*)'

zstyle ':completion:*:*:photo-sort:*' file-patterns '*(/)'
zstyle ':completion:*:*:photo-sort:*' file-sort time

compdef untilquit=pkill

# Don't complete backup files as commands.
zstyle ':completion:*:complete:-command-::*' ignored-patterns '*\~'

# Username completion.
# Delete old definitions
zstyle -d users
# For SSH and Rsync, use remote users set in SSH configuration, plus root
zstyle ':completion:*:*:(ssh|rsync):*' users root $(awk '$1 == "User" { print $2 }' ~/.ssh/config | sort -u)
# For everything else, use non-system users from /etc/passwd, plus root
zstyle ':completion:*:*:*:*' users root $(awk -F: '$3 > 1000 && $3 < 65000 { print $1 }' /etc/passwd)

# URL completion. Use URLs from history.
zstyle -e ':completion:*:*:urls' urls 'reply=( ${${(f)"$(egrep --only-matching \(ftp\|https\?\)://\[A-Za-z0-9\].\* $HISTFILE)"}%%[# ]*} )'

# End Completion stuff
###############################################################################
