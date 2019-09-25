# Set the go path
set -Ux GOPATH $HOME/go

# Add the go install dir to the path
set -x PATH $GOPATH/bin $PATH

# Add the rust install dir to the path
set -x PATH $HOME/.cargo/bin $PATH

# For some reasone i sometimes don't have this by default in my path so i'll add it
set -x PATH /home/mark/.local/bin $PATH

# Set this shell variable to nothing
# this stops the anoying gpg agent
set -Ux GPG_AGENT_INFO ""

# If thefuck is installed uncomment this
# thefuck --alias | source

# Alias vim to nvim
alias vi='nvim $argv'
alias vim='nvim $argv'

# add scale factor 2 to spotify, otherwhise the UI is really small on 4k screens with 2x scaling
alias spotify='spotify --force-device-scale-factor=2 $argv'

# Add the line underhere to bind to code to code-oss
# alias code='code-oss $argv'

# Some general shotcuts for programs
alias lg='lazygit $argv'
alias ldd='lazydocker $argv'
alias ss='sudo systemctl $argv'
alias c='code ./'
alias g='go'
alias l='ls'
alias p='pwd'

# Git shortcuts
alias commit='git commit $argv'
alias push='git push $argv'
alias add='git add $argv'
alias pull='git pull $argv'

# Bind cat to bat -p, this makes using cat so much better
alias cat='bat -p $argv'

# Cross distro bindings to make system updates a bit faster to do
alias eoup='sudo eopkg upgrade'
alias pacup='sudo pacman -Syuu'
alias dnfup='sudo dnf update'
function aptup
  sudo apt update -y
  sudo apt upgrade -y
  sudo apt autoremove -y
end

# When angular is taking up to much memory
# One of those dumb angular things
set -Ux NODE_OPTIONS "--max-old-space-size=4096"

# For running minio in a development envourment
# I don't want to always run programs like this in the background, 
# that's why i added the -it and --rm, this i always know it's running somewhere in a terminal  
alias startMinio='docker run -e "MINIO_ACCESS_KEY=BByNC8gT7WEaT5QOJLHhwBywds8e4iSaZSrwduhsm" -e "MINIO_SECRET_KEY=BcJKJBTxw8YLg9ouEETQXywTCZkxeXz28GYmAYW7R" -it --rm -p 9000:9000 --name minio -v /mnt/data:/data minio/minio server /data'
