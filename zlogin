export EDITOR=vim
if type "brew" &> /dev/null; then
  export HOMEBREW_ROOT=$(brew --prefix)
fi

_git_remote_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ -n $ref ]]; then
    echo "[%{$fg_bold[green]%}${ref#refs/heads/}%{$reset_color%}]"
  fi
}
compdef _git_remote_branch grb
