# use vim as an editor
export EDITOR=vim

export NODE_PATH=/usr/local/lib/node_modules:$NODE_PATH

# enable colored output from ls, etc
export CLICOLOR=1

# aliases
if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

# prompt
export PS1='[${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}%{$fg_bold[blue]%}%~%{$reset_color%}] '

git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ -n $ref ]]; then
    echo "[%{$fg_bold[green]%}${ref#refs/heads/}%{$reset_color%}]"
  fi
}

powerline_repo="`pwd`/powerline"
if [ -e "$powerline_repo" ]; then
  export POWERLINE_COMMAND="$powerline_repo/scripts/powerline"
  powerline_daemon_repo="`pwd`/powerline-daemon"
  if [ -e "$powerline_daemon_repo" ]; then
    # $powerline_daemon_repo/powerline-daemon --replace
    POWERLINE_COMMAND="$powerline_daemon_repo/powerline-client"
  fi
  source $powerline_repo/powerline/bindings/zsh/powerline.zsh
else
  # prompt
  export PS1="$(git_prompt_info)$PS1"
fi

