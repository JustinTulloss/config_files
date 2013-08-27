export NODE_PATH=/usr/local/lib/node_modules:$NODE_PATH

export EDITOR=vim

_git_remote_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ -n $ref ]]; then
    echo "[%{$fg_bold[green]%}${ref#refs/heads/}%{$reset_color%}]"
  fi
}
compdef _git_remote_branch grb

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
