# completion
autoload -U compinit
compinit

# automatically enter directories without cd
setopt auto_cd

# use vim as an editor
export EDITOR=vim

# aliases
if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

# vi mode
bindkey -v

# use incremental search
bindkey ^R history-incremental-search-backward

# expand functions in the prompt
setopt prompt_subst

# prompt
export PS1='[${SSH_CONNECTION+"%n@%m:"}%~] '

# ignore duplicate history entries
setopt histignoredups

# keep more history
export HISTSIZE=200

export GOPATH=$HOME/Dev/go
export PATH=/usr/local/bin:$HOME/Dev/go/bin:$PATH

if [ -e "$HOME/Dev/phd/arcanist/resources/shell/bash-completion" ]; then
  source "$HOME/Dev/phd/arcanist/resources/shell/bash-completion"
fi

__git_files () { 
  _wanted files expl 'local files' _files
}

if [ -e "/usr/local/share/python/virtualenvwrapper.sh" ]; then
  export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
  source /usr/local/share/python/virtualenvwrapper.sh
fi
