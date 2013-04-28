#=================##
## File Operation ##
##=================#
fpath=(~/.zsh/zsh-completions/src $fpath)
autoload -U ~/.zsh/zsh-completions/*(:t)
autoload -U compinit && compinit
setopt auto_cd
setopt auto_pushd
setopt correct
setopt magic_equal_subst
setopt nobeep
setopt prompt_subst
setopt list_packed
zstyle ':completion:*' verbose yes
zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%B[%d]%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches: %d'
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

#=========##
## PROMPT ##
##=========#
autoload -U colors && colors
PROMPT="%B%{[33m%}%n:%{[m%}%b "
PROMPT2="%B%{[33m%}%_%{[m%}%b "
SPROMPT="%BDid you mean %{[31m%}%r? [n,y,a,e]:%{[m%}%b "
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
RPROMPT="%{[34m%}[%~]%{[m%}"

#==========##
## HISTORY ##
##==========#
HISTFILE=~/.backup/zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt extended_history
setopt hist_ignore_dups	#ignore duplication command history list
setopt share_history	#share command history data
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

#================##
## ALIAS COMMAND ##
##================#
setopt complete_aliases
alias ls="ls -G -w -h"
alias la="ls -a"
alias lf="ls -F"
alias ll="la -lh"
alias du="du -h"
alias df="df -h"
alias vi="vim"
alias ga="git add"
alias gpu="git push"
alias gco="git commit"
alias gcl="git clone"
alias gpl="git pull"
alias bu="brew update"
alias br="brew upgrade"
alias bs="brew -S"
alias bi="brew info"
alias rl="/usr/local/bin/r"
alias -s {txt,md,markdown,xml}=lv
alias -s py=python
alias -s hs=runhaskell
if [ `uname` = "Darvin" ]; then
    alias preview='open -a Preview'
fi
alias -s {gif,png,jpg,bmp,pdf,GIF,PNG,JPG,BMP,PDF}=preview
if [ `uname` = "Darwin" ]; then
    alias google-chrome='open -a Google\ Chrome'
fi
alias chrome='google-chrome'
alias -s html=chrome
function extract() {
case $1 in
    *.tar.gz|*.tgz) tar xzvf $1;;
*.tar.xz) tar Jxvf $1;;
    *.zip) unzip $1;;
*.lzh) lha e $1;;
    *.tar.bz2|*.tbz) tar xjvf $1;;
*.tar.Z) tar zxvf $1;;
    *.gz) gzip -dc $1;;
*.bz2) bzip2 -dc $1;;
    *.Z) uncompress $1;;
*.tar) tar xvf $1;;
    *.arj) unarj $1;;
esac
}
alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz}=extract
function runcpp () { g++ -O2 $1; ./a.out }
alias -s {c,cpp}=runcpp

#================================##
## Version Control for Languages ##
##================================#
# rbenv
if [ -s rbenv ]; then
    eval "$(rbenv init - zsh)"
    source "`brew --prefix rbenv`/completions/rbenv.zsh"
fi

# perlbrew
if which perlbrew > /dev/null; then
    source "$HOME/perl5/perlbrew/etc/bashrc"
fi

# pythonbrew
if [ -s "$HOME/.pythonbrew/etc/bashrc" ]; then
    source "$HOME/.pythonbrew/etc/bashrc"
    alias mkvirtualenv="pythonbrew venv create"
    alias rmvirtualenv="pythonbrew venv delete"
    alias workon="pythonbrew venv use"
fi

#====##
## z ##
##===#
. $HOME/.zsh/z/z.sh
precmd() {
    z --add "$(pwd -P)"
}

#==========================##
## zsh-syntax-highligthdng ##
##==========================#
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#========##
## stacx ##
##========#
show_buffer_stack() {
    POSTDISPLAY="
    stack: $LBUFFER"
    zle push-line-or-edit
}
zle -N show_buffer_stack
setopt noflowcontrol
bindkey '^Q' show_buffer_stack
