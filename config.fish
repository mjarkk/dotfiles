# Set the go path
set -Ux GOPATH $HOME/go

# Add the go install dir to the path
set -x PATH $GOPATH/bin $PATH

# Add the rust install dir to the path
set -x PATH $HOME/.cargo/bin $PATH

# Set this shell variable to nothing
# this stops the anoying gpg agent
set -Ux GPG_AGENT_INFO ""

# add scale factor 2 to spotify, otherwhise the UI is really small on 4k screens with 2x scaling
alias spotify='spotify --force-device-scale-factor=2 $argv'

# Add the line underhere to bind to code to code-oss
# alias code='code-oss $argv'

# Some general shotcuts for programs
alias lg='lazygit $argv'
alias ld='lazydocker $argv'
alias ss='sudo systemctl $argv'
alias c='code ./'

# Bind cat to bat -p, this makes using cat so much better
alias cat='bat -p $argv'

# Cross distro bindings to make system updates a bit faster to do
alias eoup='sudo eopkg upgrade'
alias pacup='sudo pacman -Syuu'
function aptup
  sudo apt update -y
  sudo apt upgrade -y
  sudo apt autoremove -y
end
