# zshrc
COLOR_1=237
COLOR_2=191
COLOR_3=244
COLOR_4=141
NEWLINE=$'\n'

setopt PROMPT_SUBST
setopt globdots
unsetopt beep

# enable completion menu
autoload -Uz compinit && compinit
compinit -D $ZDOTDIR/.zcompdump
zmodload zsh/complist
zstyle ':completion:*' menu select
bindkey -v

# change cursor shape based on vi mode
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey '^?' backward-delete-char

export KEYTIMEOUT=1

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
 echo -ne '\e[6 q'
}
zle -N zle-line-init
echo -ne '\e[6 q'
preexec() {
 echo -ne '\e[6 q';
}

# git integration
autoload -Uz add-zsh-hook
autoload -Uz vcs_info

add-zsh-hook precmd vcs_info

zstyle ':vcs_info:git:*' formats '%F{cyan}%c%u(%48>…>%b%>>%)%f'
zstyle ':vcs_info:git:*' actionformats '%F{cyan}%c%u(%48>…>%b%>>%)%f %F{yellow}! %a%f'
zstyle ':vcs_info:git:*' stagedstr '%F{green}'
zstyle ':vcs_info:git:*' unstagedstr '%F{red}'
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

+vi-git-untracked() {
  if git --no-optional-locks status --porcelain 2> /dev/null | grep -q '^??'; then
    hook_com[staged]+='%F{red}'
  fi
}

# prompt configuration
PROMPT='%F{ ${COLOR_1} }${(r:$COLUMNS::─:)}'
PROMPT+='${NEWLINE}'
PROMPT+='%F{ ${COLOR_2} }☡ '
PROMPT+='%F{ ${COLOR_3} }(%T) '
PROMPT+='%F{ ${COLOR_4} }%n%f @ '
PROMPT+='%F{ ${COLOR_2} }%1~/%f '
PROMPT+='${vcs_info_msg_0_}'
PROMPT+='${NEWLINE}'
PROMPT+='%F{ ${COLOR_3} }└╴%f$ '

# aliases
alias z='open -a zed'
alias chrm='open -a google\ chrome'
alias dcrd='open -a discord'
alias frfx='open -a firefox'
alias sfri='open -a safari'
alias sptf='open -a spotify'
alias tblp='open -a tableplus'
alias finder='open -a finder'

# nvm
export NVM_DIR=$HOME/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
