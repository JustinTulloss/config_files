#!/bin/sh

cutstring="DO NOT EDIT BELOW THIS LINE"

for name in *; do
  target="$HOME/.$name"
  if [ -e $target ]; then
    echo "Backing up old file"
    mv $target $target.bak
  fi

    if [ $name != 'install.sh' ]; then
      echo "Creating $target"
      ln -s "$PWD/$name" "$target"
    fi
done
