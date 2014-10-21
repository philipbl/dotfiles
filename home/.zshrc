# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="robbyrussell"
ZSH_THEME="af-magic"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git github osx terminalapp brew pip python autojump sublime colored-man colorize cp compleat lein)

source $ZSH/oh-my-zsh.sh

# User configuration

# Virtual env wrapper
# source /usr/local/bin/virtualenvwrapper.sh

# Allow git to do the globing not zsh
alias git='noglob git'

# Git number aliases
alias gn='git number'
alias ga='git number add'

# SSH aliases
alias camera='ssh -p 9123 -L 8090:192.168.0.200:8090 bridgetlundrigan@75.162.179.138'
alias vnc='ssh -p 9123 -L 5901:192.168.0.2:5901 bridgetlundrigan@75.162.179.138'

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Android stuff
export PATH="$PATH:/Applications/Android Studio.app/sdk/platform-tools"
export ANDROID_HOME="/Applications/Android Studio.app/sdk"

# Add my bin to PATH
export PATH="$HOME/bin:$PATH"



# Little alias for open
function o {
    if [ -z "$1" ]
    then
        open .
    else
        open $1
    fi
}


# Allows vim to catch Ctrl-S and such
alias vim="stty stop '' -ixoff ; vim"
# `Frozing' tty, so after any command terminal settings will be restored
ttyctl -f

bindkey '^B' push-line-or-edit

source "$HOME/.homesick/repos/homeshick/homeshick.sh"
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)

