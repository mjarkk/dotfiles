set -Ux GOPATH $HOME/go
set -x PATH $GOPATH/bin $PATH
set -x PATH $HOME/.cargo/bin $PATH

alias spotify='spotify --force-device-scale-factor=2 $argv'

function lg
  lazygit $argv
end

function ss
  sudo systemctl $argv
end

function c 
  code ./
end

function pacup 
  sudo pacman -Syuu
end

function aptup
  sudo apt update -y
  sudo apt upgrade -y
  sudo apt autoremove -y
end
