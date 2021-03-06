function fish_greeting
end

# Go shell vars
set -Ux GOPATH $HOME/go
set -x PATH $GOPATH/bin $PATH

# Rust and Cargo shell vars
set -x PATH $HOME/.cargo/bin $PATH
set -Ux CARGO_NAME "mjarkk"
set -Ux CARGO_EMAIL "mkopenga@gmail.com"

# PHP Composer global installed packages
set -x PATH $HOME/.composer/vendor/bin $PATH

# For some reasone i sometimes don't have this by default in my path so i'll add it
# I think this was mainly for running snap packages easially in the terminal
set -x PATH /home/mark/.local/bin $PATH

# On some linux distro's there is a popup for filling in the gpg passphrase and i don't like that
set -Ux GPG_AGENT_INFO ""

# Git config, so i don't have to setup this every time
set -Ux GIT_AUTHOR_NAME "mjarkk"
set -Ux GIT_AUTHOR_EMAIL "mkopenga@gmail.com"

# Give node a shitload of memory just so angular can do it's "special" things
set -Ux NODE_OPTIONS "--max-old-space-size=4096"

# Disable analytics for some programs
set -Ux NG_CLI_ANALYTICS "false" # Angular
set -Ux NEXT_TELEMETRY_DISABLED "1" # Next.js

# If thefuck is installed set it up automaticly
if type -q thefuck
  thefuck --alias | source
end

# Alias php artisan for ease of use
if type -q php
  alias artisan='php artisan'
end

# Use nvim everywhere
if type -q nvim
  set -Ux EDITOR "nvim"
  set -Ux GIT_EDITOR "nvim"
  alias vi="nvim"
  alias vim="nvim"
else
  set -Ux EDITOR "nano"
end

# some distros install the open source edition of vs-code, bind that to code if that's the case
if type -q code-oss
  alias code='code-oss'
end

# If discord won't die
alias killDiscord='kill discord && kill discord'

# Some general shotcuts for programs
alias lg='lazygit'
alias ss='sudo systemctl'
alias c='code ./'
alias g='go'
alias l='ls'
alias p='pwd'
alias startDocker='ss start docker'

function open
  if uname | grep 'Darwin' > /dev/null
    /usr/bin/open $argv
  else
    xdg-open $argv
  end
end

# Shortcut to untar something
alias untar='tar xvzf'

# Git shortcuts
alias commit='git commit'
alias push='git push'
alias add='git add'
alias pull='git pull'
alias branch="git for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"
alias git-stat='git diff --stat' # Show some nice git stats
alias gitstat='git-stat'
alias gitStat='git-stat'
alias checkdev='git checkout development' # Checkout development
alias checkmas='git checkout master' # Checkout master

# easially find all systems ips
alias ips='ip addr | grep "\([0-9]\{1,3\}\.\)\{3\}\([0-9]\{1,3\}\)" | sed -e "s/^[ \t]*//" | grep -v "127\.0\.0\.1"'

# Bind cat to bat -p, this makes using cat sooo much better
if type -q bat
  alias cat='bat -p'
end

# Bind ls to exa, exa has some nice things that make using ls just a bit better
if type -q exa
  alias ls='exa'
end

# Set a docker alias to podman as most docker commands work with podman
if type -q podman
  alias docker='podman'
end

# Alias to start code-server
alias startCodeServer='sudo systemctl start --now code-server@$USER'

# Cross distro bindings to make system updates a bit faster
alias flatup='flatpak update -y'
alias rusup='rustup update'
function brewup
  brew update
  brew upgrade
end
alias eoup='sudo eopkg upgrade'
alias pacup='sudo pacman -Syuu --noconfirm'
alias yayup='yay -Syuu --noeditmenu --answerdiff None --answeredit None --answerclean None --noconfirm'
alias dnfup='sudo dnf update -y'
alias xbpsup='sudo xbps-install -Syu'
function aptup
  sudo apt update -y
  sudo apt upgrade -y
  sudo apt autoremove -y
end

function up
  set ID_LIKE (grep "^ID_LIKE=" /etc/os-release | sed 's/ID_LIKE=//' | sed 's/"//g')
  set ID (grep "^ID=" /etc/os-release | sed 's/ID=//' | sed 's/"//g')

  if [ $ID = 'arch' ] || [ $ID_LIKE = 'arch' ]
    if type -q yay
      yayup
    else
      pacup
    end
  else if [ $ID_LIKE = 'ubuntu debian' ] || [ $ID_LIKE = 'debian' ] || [ $ID_LIKE = 'ubuntu' ] ||  [ $ID = 'ubuntu' ] || [ $ID = 'debian' ]
    aptup
  else if [ $ID = 'solus' ] || [ $ID_LIKE = 'solus' ]
    eoup
  else if [ $ID = 'void' ] || [ $ID_LIKE = 'void' ]
    xbpsup
  else if [ $ID = 'fedora' ] || [ $ID_LIKE = 'fedora' ]
    dnfup
  else
    echo 'Unknown distro: $ID'
  end

  # Also check for flatpak and rust updates if installed
  if type -q flatpak
    flatup
  end
  if type -q rustup
    rusup
  end
end

# Post setup config edit and run
alias editPostSetup='$EDITOR ~/.postSetup.sh'
alias postSetup='sh ~/.postSetup.sh'

alias startMongo='mongod --config /usr/local/etc/mongod.conf'
alias startRedis='redis-server /usr/local/etc/redis.conf'

# For running minio in a development envourment
# I don't like wasting cpu power nor do i want to have a program i don't usually use running in the background.
# That's why i use it this way, now i can start it in a terminal tab and never forget that some bs is running in the background.
alias startMinio='docker run -e "MINIO_ACCESS_KEY=BByNC8gT7WEaT5QOJLHhwBywds8e4iSaZSrwduhsm" -e "MINIO_SECRET_KEY=BcJKJBTxw8YLg9ouEETQXywTCZkxeXz28GYmAYW7R" -it --rm -p 9000:9000 --name minio -v /mnt/data:/data minio/minio server /data'

