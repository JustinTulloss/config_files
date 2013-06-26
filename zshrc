# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="muse"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=()

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=$PATH:/usr/local/heroku/bin:/usr/local/bin:/usr/local/bin:/Users/justin/Dev/go/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/usr/local/heroku/bin:/Users/justin/Dev/go/bin:/usr/local/mysql/bin:/usr/local/sbin:/Users/justin/bin:/Users/justin/Dev/arcanist/arcanist/bin:/usr/local/mysql/bin:/usr/local/sbin:/Users/justin/bin:/Users/justin/Dev/arcanist/arcanist/bin
export EDITOR vim
export GOPATH=$HOME/Dev/go

if [ -e "/usr/local/share/python/virtualenvwrapper.sh" ]; then
  export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
  source /usr/local/share/python/virtualenvwrapper.sh
fi

if [ -e "$HOME/Dev/phd/arcanist/resources/shell/bash-completion" ]; then
  source "$HOME/Dev/phd/arcanist/resources/shell/bash-completion"
fi
