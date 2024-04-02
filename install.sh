#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"

print_green() {
  echo -e "${GREEN}$1${ENDCOLOR}"
}

print_red() {
  echo -e "${RED}$1${ENDCOLOR}"
}

print() {
  echo $1
}

print_exit() {
  print_red "$1"
  print_red "Exiting..."
  exit 1
}

read -e -p "Hey there! Please enter the root of your config folder: " root_tmp
root=${root_tmp/\~/$HOME}
current_dir=$PWD
readonly root current_dir
echo "Checking if $root exists"

if [ -d $root ]; then print_green "$root exists"
else print_exit "$root does not exist"
fi

echo "Configuring Helix..."
helix_root=$root/helix
if [ ! -d $helix_root ]; then mkdir $helix_root
fi
ln -s -i $current_dir/helix/config.toml $helix_root/config.toml
ln -s -i $current_dir/helix/ignore $helix_root/ignore
ln -s -i $current_dir/helix/languages.toml $helix_root/languages.toml
print_green "Helix configured"

echo "Configuring Kitty"
kitty_root=$root/kitty
if [ ! -d $kitty_root ]; then mkdir $kitty_root
fi
ln -s -i $current_dir/kitty/kanagawa.conf $kitty_root/kanagawa.conf
ln -s -i $current_dir/kitty/kitty.conf $kitty_root/kitty.conf
ln -s -i $current_dir/kitty/session.conf $kitty_root/session.conf
print_green "Kitty configured"

echo "Configuring Daktilo"
daktilo_root=$root/daktilo
if [ ! -d $daktilo_root ]; then mkdir $daktilo_root
fi
ln -s -i $current_dir/daktilo/daktilo.toml $daktilo_root/daktilo.toml
ln -s -i $current_dir/daktilo/press $daktilo_root/press
ln -s -i $current_dir/daktilo/release $daktilo_root/release
print_green "Daktilo configured"

echo "Configuring gitui"
gitui_root=$root/gitui
if [ ! -d $gitui_root ]; then mkdir $gitui_root
fi
ln -s -i $current_dir/gitui/theme.ron $gitui_root/theme.ron
print_green "gitui configured"
