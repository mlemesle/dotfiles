RED="\033[0;31m"
GREEN="\033[0;32m"
RESET="\033[0m"

print_success() {
  echo -e "${GREEN}Successfully bumped $1${RESET}"
}

print_error() {
  echo -e "${RED}$1 isn't a command that can be bumped${RESET}"
}

bump() {
  case "$1" in
    kitty )
      curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin \
        launch=n;
      print_success $1;
      ;;

    helix )
      local initial_path=`pwd`;
      cd ~/helix;
      git fetch;
      git pull;
      cargo install --path helix-term --locked;
      cd $initial_path;
      print_success $1;
      ;;

    ghostty )
      local initial_path=`pwd`;
      cd ~/ghostty;
      git fetch;
      git pull;
      sudo zig build -p /usr -Doptimize=ReleaseFast;
      cd $initial_path;
      print_success $1;
      ;;

    * )
      print_error $1;
      ;;
  esac
}
