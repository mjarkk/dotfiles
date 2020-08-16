function fish_greeting
end

# Go shell vars
set -Ux GOPATH $HOME/go
set -x PATH $GOPATH/bin $PATH

# Rust and Cargo shell vars
set -x PATH $HOME/.cargo/bin $PATH
set -Ux CARGO_NAME "mjarkk"
set -Ux CARGO_EMAIL "mkopenga@gmail.com"

# For some reasone i sometimes don't have this by default in my path so i'll add it
set -x PATH /home/mark/.local/bin $PATH

# On some linux distro's there is a popup for filling in the gpg passphrase and i don't like that
set -Ux GPG_AGENT_INFO ""

# Git config, so i don't have to setup this every time
set -Ux GIT_AUTHOR_NAME "mjarkk"
set -Ux GIT_AUTHOR_EMAIL "mkopenga@gmail.com"

# Give node a shitload of memory just so angular can do it's special things
set -Ux NODE_OPTIONS "--max-old-space-size=4096"

# If thefuck is installed set it up automaticly
if type -q thefuck
  thefuck --alias | source
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
alias open='xdg-open'

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

# Bind cat to bat -p, this makes using cat sooo much better
if type -q bat
  alias cat='bat -p'
end

# Bind ls to exa, exa has some nice things that make using ls just a bit better
if type -q exa
  alias ls='exa'
end

# Cross distro bindings to make system updates a bit faster
alias eoup='sudo eopkg upgrade'
alias pacup='sudo pacman -Syuu --noconfirm'
alias yayup='yay -Syuu --noeditmenu --answerdiff None --answeredit None --answerclean None --noconfirm'
alias dnfup='sudo dnf update'
alias xbpsup='sudo xbps-install -Syu'
function aptup
  sudo apt update -y
  sudo apt upgrade -y
  sudo apt autoremove -y
  if type -q flatpak
    flatpak update -y
  end
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
  else if [ $ID_LIKE = 'ubuntu debian' ] || [ $ID_LIKE = 'debian' ] || [ $ID = 'ubuntu' ] || [ $ID = 'debian' ]
    aptup
  else
    echo 'Unknown distro: $ID'
  end
end

# Post setup config edit and run
alias editPostSetup='$EDITOR ~/.postSetup.sh'
alias postSetup='sh ~/.postSetup.sh'

# For running minio in a development envourment
# I don't like wasting cpu power nor do i want to have a program i don't usually use running in the background.
# That's why i use it this way, now i can start it in a terminal tab and never forget that some bs is running in the background.
alias startMinio='docker run -e "MINIO_ACCESS_KEY=BByNC8gT7WEaT5QOJLHhwBywds8e4iSaZSrwduhsm" -e "MINIO_SECRET_KEY=BcJKJBTxw8YLg9ouEETQXywTCZkxeXz28GYmAYW7R" -it --rm -p 9000:9000 --name minio -v /mnt/data:/data minio/minio server /data'

