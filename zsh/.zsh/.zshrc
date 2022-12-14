# zsh config
LINEBR=$'\n'
PROMPT="${LINEBR}%B[%T] %F{214}%n %F{255}@ %F{214}%U%1~%u %F{255}$%f%b "

HISTFILE=~/.zsh/.zhistory
HISTSIZE=10000
SAVEHIST=10000
unsetopt beep

autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

bindkey -v
export KEYTIMEOUT=1

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey "^?" backward-delete-char

# change cursor shape depending on vi mode
function zle-keymap-select {
 if [[ ${KEYMAP} == vicmd ]] ||
    [[ $1 = 'block' ]]; then
  echo -ne '\e[2 q'
 elif [[ ${KEYMAP} == main ]] ||
    [[ ${KEYMAP} == viins ]] ||
    [[ ${KEYMAP} = '' ]] ||
    [[ $1 = 'beam' ]]; then
  echo -ne '\e[6 q'
 fi
}
zle -N zle-keymap-select
zle-line-init() {
 zle -K viins
 echo -ne "\e[6 q"
}
zle -N zle-line-init
echo -ne '\e[6 q'
preexec() { echo -ne '\e[6 q' ;}

# git
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT='%F{202}${vcs_info_msg_0_}%f'
zstyle ':vcs_info:git:*' formats '%b'

# docker
fpath=(~/.zsh/completion $fpath)

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# php
export PATH="/usr/local/opt/php@7.4/bin:$PATH"
export PATH="/usr/local/opt/php@7.4/sbin:$PATH"
export LDFLAGS="-L/usr/local/opt/php@7.4/lib"
export CPPFLAGS="-I/usr/local/opt/php@7.4/include"

# aliases
alias sc="cmatrix -C white"
alias dcrd="open -a discord"
alias frfx="open -a firefox"
alias chrm="open -a google\ chrome"
alias sfri="open -a safari"
alias sptf="open -a spotify";
