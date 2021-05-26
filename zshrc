command_exists () {
  type "$1" &> /dev/null ;
}

fpath=($HOMEBREW_ROOT/share/zsh/site-functions $fpath)

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

# ignore duplicate history entries
setopt histignoredups

# keep more history
export HISTSIZE=20000
export HISTFILE=~/.zsh-history
export SAVEHIST=$HISTSIZE
setopt appendhistory # append history to history file
setopt sharehistory # share across terminals
setopt incappendhistory # immediately append

export GOPATH=$HOME/go
export GOROOT="$(brew --prefix golang)/libexec/"
PATH=./node_modules/.bin:/usr/local/bin:/usr/local/mysql/bin:/usr/local/sbin:/usr/local/opt/ruby/bin:/opt/boxen/homebrew/opt/go/libexec/bin:~/.bin/eb/macosx/python2.7:$GOPATH/bin:$PATH

if [ -e "/usr/local/bin/virtualenvwrapper.sh" ]; then
  export WORKON_HOME=$HOME/.virtualenvs
  export PROJECT_HOME=$HOME/src
  source /usr/local/bin/virtualenvwrapper.sh
fi

if [ -f $HOME/.aliases ]; then
  source $HOME/.aliases
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

if [ -d "$HOME/google-cloud-sdk/" ]; then
  # The next line updates PATH for the Google Cloud SDK.
  source "$HOME/google-cloud-sdk/path.zsh.inc"

  # The next line enables bash completion for gcloud.
  source "$HOME/google-cloud-sdk/completion.zsh.inc"
fi

# Support for hackon
[[ -s "$HOME/src/scripts/rvm" ]] && source $HOME/src/hackon/hackon.sh

# RVM support. RVM is evil so don't always have this enabled.
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# rbenv support
if type "rbenv" &> /dev/null; then
  eval "$(rbenv init -)"
fi

if [ -d "$HOME/stripe/space-commander/bin" ]; then
  export PATH="$HOME/stripe/space-commander/bin:$PATH"
fi

if [ -d "$HOME/stripe/password-vault/bin" ]; then
  export PATH="$HOME/stripe/password-vault/bin:$PATH"
fi

# nodenv support
if [ -d $HOME/.nodenv/shims ]; then
  export PATH="$HOME/.nodenv/bin:$PATH"
  eval "$(nodenv init -)"
fi

if [ -f ~/.fzf.zsh ]; then
  source ~/.fzf.zsh
fi

if [ -f $HOME/.cargo/env ]; then
 source $HOME/.cargo/env
fi

export FZF_DEFAULT_COMMAND='rg --files --follow'
