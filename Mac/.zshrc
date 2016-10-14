fpath=(/usr/local/share/zsh-completions $fpath)
autoload -Uz compinit
compinit
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# export SVN_EDITOR=vim

# プロンプト
autoload -U colors; colors
local p_current="[%{$fg[red]%}%~%{$reset_color%}]"$'\n'
local p_info="%F{yellow}%n@%m%f > "
PROMPT="$p_current$p_info"
RPROMPT='%F{yellow}[%D]%f'
setopt transient_rprompt

#nprom () {
#    setopt prompt_subst
#    local rbase=$'%{\e[33m%}[%%{\e[m%}' lf=$'\n'
#    local pct=$'%0(?||%18(?||%{\e[31m%}))%#%{\e[m%}'
#    RPROMPT="%9(~||$rbase)"
#    case "$USER" in
#      yatex)  PROMPT=$'%{\e[33m%}%U%m{%n}%%%{\e[m%}%u ' ;;
#      java) PROMPT=$'%{\e[36m%}%U%m{%n}%%%{\e[m%}%u ' ;;
#      *)
#    local pbase=$'%{\e[$[32+RANDOM%5]m%}%U%B%m{%n}%b'"$pct%u "
#    PROMPT="%9(~|$rbase$lf|)$pbase"
#    ;;
#    esac
#    [[ "$TERM" = "screen" ]] && RPROMPT="[%U%~%u]"
#}
#nprom

# rbenv
# echo 'export PATH="$HOME/.rbenv/bin:$PATH"'
# eval "$(rbenv init -)"

# エイリアスいろいろ
export LSCOLORS=gxfxcxdxbxegedabagacad
alias ls='ls -F --color'
alias ll='ls -Fl'
alias la='ls -Fla'
alias v='vim -R'
alias p='pwd'
alias mv='mv -vi'
alias cp='cp -vi'
alias rm='rm -vi'
# alias diff='colordiff -u'
alias less='less -R'
#alias top='htop'
alias wee='weechat-curses'
alias iftop='/usr/local/Cellar/iftop/1.0pre2/sbin/iftop'

# ~/.ssh/known_hostsをつかったホスト名の補完
function print_known_hosts (){
  if [ -f $HOME/.ssh/known_hosts ]; then
    cat $HOME/.ssh/known_hosts | tr ',' ' ' | cut -d' ' -f1
  fi
}
_cache_hosts=($( print_known_hosts ))

# rbenv
# eval "$(rbenv init -)"

function tm() { 
       if [ -n "${1}" ]; then
           tmux attach-session -t ${1} || \
           tmux new-session -s ${1}
    else
           tmux attach-session || \
           tmux new-session
       fi
}
