fpath=(/usr/local/share/zsh-completions $fpath)

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
PATH=/usr/local/bin:/usr/local/mysql/bin:/usr/local/sbin:/usr/local/opt/ruby/bin:$PATH

if [ -e "$HOME/Dev/arcanist/arcanist/resources/shell/bash-completion" ]; then
  source "$HOME/Dev/arcanist/arcanist/resources/shell/bash-completion"
  PATH=$HOME/Dev/arcanist/arcanist/bin:$PATH
fi

if [ -e "/usr/local/bin/virtualenvwrapper.sh" ]; then
  export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
  source /usr/local/bin/virtualenvwrapper.sh
fi

__git_files () { 
  _wanted files expl 'local files' _files
}

autoload -U colors
colors

# prompt
git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ -n $ref ]]; then
    echo "[%{$fg_bold[green]%}${ref#refs/heads/}%{$reset_color%}]"
  fi
}

export PS1='[${SSH_CONNECTION+"%{$fg_bold[yellow]%}%n@%m:"}%{$fg_bold[blue]%}%2c%{$reset_color%}] '
export RPROMPT='$(git_prompt_info)'
