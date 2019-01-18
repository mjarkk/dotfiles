set -Ux GOPATH $HOME/go
set -x PATH $GOPATH/bin /opt/android-sdk/platform-tools /home/mark/Android/Sdk/emulator $PATH

function lg
  lazygit $argv
end
