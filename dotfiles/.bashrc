# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  ;;
*) ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
export PATH="$HOME/.fzf/bin:$PATH"
export TERM="xterm-256color"
export EDITOR=nvim
export PATH="$PATH:/opt/nvim/"
bind '"\t":menu-complete'

# Added by `rbenv init` on pią, 31 sty 2025, 12:08:06 CET
eval "$(~/.rbenv/bin/rbenv init - --no-rehash bash)"
. $HOME/.asdf/asdf.sh
. "$HOME/.cargo/env"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# =====================================================
# DODATKOWE ALIASY I FUNKCJE
# Dodaj na końcu swojego .bashrc
# =====================================================

# Przydatne aliasy
alias ll='ls -alF'
alias la='ls -A' 
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Git aliasy (skoro używasz programowania)
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'

# Nvim aliasy
alias vim='nvim'
alias vi='nvim'
alias v='nvim'

# Bezpieczne operacje
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# System info
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias ports='netstat -tulanp'

# Funkcje
# Utwórz katalog i przejdź do niego
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Git branch w prompt (jeśli chcesz dodać info o git)
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Ulepszona funkcja find z fzf
ff() {
    if command -v fzf >/dev/null 2>&1; then
        find . -type f | fzf
    else
        find . -type f -iname "*$1*"
    fi
}

# Szybkie znajdowanie w historii z fzf
h() {
    if command -v fzf >/dev/null 2>&1; then
        history | fzf | cut -c 8-
    else
        history | grep "$1"
    fi
}

# Funkcja do szybkiego uruchamiania serwerów
serve() {
    local port="${1:-8000}"
    if command -v python3 >/dev/null 2>&1; then
        echo "Serwer uruchomiony na http://localhost:$port"
        python3 -m http.server "$port"
    elif command -v python >/dev/null 2>&1; then
        echo "Serwer uruchomiony na http://localhost:$port"  
        python -m SimpleHTTPServer "$port"
    else
        echo "Python nie jest zainstalowany"
    fi
}

# Informacje o systemie
sysinfo() {
    echo "===== SYSTEM INFO ====="
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p 2>/dev/null || uptime)"
    echo "User: $USER"
    echo "Shell: $SHELL"
    echo "Date: $(date)"
    echo "Memory:"
    free -h 2>/dev/null || free
    echo "Disk usage:"
    df -h | head -5
}

# FZF konfiguracja (jeśli chcesz dostosować)
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_DEFAULT_COMMAND='find . -type f -not -path "*/\.*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Dodatkowe zmienne środowiskowe
export HISTTIMEFORMAT="%F %T "  # Timestamps w historii
export LESS="-R"                # Kolorowe less