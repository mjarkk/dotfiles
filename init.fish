# Set the go path
set -Ux GOPATH $HOME/go
set -Ux GO111MODULE auto

# Add the go install dir to the path
set -x PATH $GOPATH/bin $PATH

# Add the rust install dir to the path
set -x PATH $HOME/.cargo/bin $PATH

# For some reasone i sometimes don't have this by default in my path so i'll add it
set -x PATH /home/mark/.local/bin $PATH

# On some linux distro's there is a popup for filling in the gpg passphrase and i don't like that
set -Ux GPG_AGENT_INFO ""

# If thefuck is installed uncomment this, uncommented because it takes long to start
# thefuck --alias | source

# Alias vim to nvim
alias vi='nvim'
alias vim='nvim'

# Add the line underhere to bind to code to code-oss, some distros install the open source edition for some reason
# alias code='code-oss'

# If discord won't die
alias killDiscord='kill discord && kill discord'

# Some general shotcuts for programs
alias lg='lazygit'
alias ldd='lazydocker'
alias ss='sudo systemctl'
alias c='code ./'
alias g='go'
alias l='ls'
alias p='pwd'
alias startDocker='ss start docker'

# Shortcut to untar something
alias untar='tar xvzf'

# Git shortcuts
alias commit='git commit'
alias push='git push'
alias add='git add'
alias pull='git pull'
alias git-stat='git diff --stat' # Show some nice git stats
alias gitstat='git-stat'
alias gitStat='git-stat'
alias checkdev='git checkout development' # Checkout development
alias checkmas='git checkout master' # Checkout master

# Bind cat to bat -p, this makes using cat so much better
alias cat='bat -p'

# Cross distro bindings to make system updates a bit faster to do
alias eoup='sudo eopkg upgrade'
alias pacup='sudo pacman -Syuu'
alias yayup='yay -Syuu'
alias dnfup='sudo dnf update'
alias xbpsup='sudo xbps-install -Syu'
function aptup
  sudo apt update -y
  sudo apt upgrade -y
  sudo apt autoremove -y
end

# Give node a shitload of memory just so angular can do it's special things
set -Ux NODE_OPTIONS "--max-old-space-size=4096"

# For running minio in a development envourment
# I don't want to always run programs like this in the background, 
# that's why i added the -it and --rm, this i always know it's running somewhere in a terminal  
alias startMinio='docker run -e "MINIO_ACCESS_KEY=BByNC8gT7WEaT5QOJLHhwBywds8e4iSaZSrwduhsm" -e "MINIO_SECRET_KEY=BcJKJBTxw8YLg9ouEETQXywTCZkxeXz28GYmAYW7R" -it --rm -p 9000:9000 --name minio -v /mnt/data:/data minio/minio server /data'

