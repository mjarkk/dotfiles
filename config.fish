set -Ux GOPATH $HOME/go
set -x PATH $GOPATH/bin $PATH

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

