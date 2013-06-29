# completion
autoload -U compinit
compinit

# makes color constants available
autoload -U colors
colors

# automatically enter directories without cd
setopt auto_cd

# expand functions in the prompt
setopt prompt_subst

# vi mode
bindkey -v

# use incremental search
bindkey ^R history-incremental-search-backward

# expand functions in the prompt
setopt prompt_subst

# ignore duplicate history entries
setopt histignoredups

# keep more history
export HISTSIZE=200

export GOPATH=$HOME/Dev/go
export PATH=/usr/local/bin:/usr/local/mysql/bin:/usr/local/sbin:$HOME/bin:/usr/local/opt/ruby/bin:$HOME/Dev/go/bin:$PATH

if [ -e "$HOME/Dev/phd/arcanist/resources/shell/bash-completion" ]; then
  source "$HOME/Dev/phd/arcanist/resources/shell/bash-completion"
fi

__git_files () { 
    _wanted files expl 'local files' _files     
}

if [ -e "/usr/local/bin/virtualenvwrapper.sh" ]; then
  export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
  source /usr/local/bin/virtualenvwrapper.sh
fi


_git_remote_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ -n $ref ]]; then
    if (( CURRENT == 2 )); then
      # first arg: operation
      compadd create publish rename delete track
    elif (( CURRENT == 3 )); then
      # second arg: remote branch name
      compadd `git branch -r | grep -v HEAD | sed "s/.*\///" | sed "s/ //g"`
    elif (( CURRENT == 4 )); then
      # third arg: remote name
      compadd `git remote`
    fi
  else;
    _files
  fi
}
compdef _git_remote_branch grb
