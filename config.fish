if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_greeting
end

# Semi-common path folders
set -x PATH /opt/local/bin $PATH
set -x PATH $HOME/.local/bin $PATH

# Common linux things..
# set -x PATH $HOME/Documents/flutter/bin $PATH
# set -Ux CHROME_EXECUTABLE "$HOME/.local/share/flatpak/exports/bin/com.google.Chrome"

if test -d ~/.deno/bin
    set -x PATH $HOME/.deno/bin $PATH
end

if test -d ~/.bun/bin
    set -x PATH $HOME/.bun/bin $PATH
end

if test -d ~/.fly/bin
   set -Ux FLYCTL_INSTALL $HOME/.fly
   set -x PATH $FLYCTL_INSTALL/bin $PATH
end

if test -d ~/.ghcup/bin
    set -x PATH $HOME/.ghcup/bin $PATH
end

# Php shell vars
if type -q php
    set -x PATH $HOME/.composer/vendor/bin $PATH
    alias composer='php $HOME/.composer/composer'
    alias artisan='php artisan'
end

# Go shell vars
if type -q go
    set -Ux GOPATH $HOME/go
    set -x PATH $GOPATH/bin $PATH
    set -Ux GOPRIVATE bitbucket.org/teamscript
    alias app='go run .'
end

# Rust and Cargo shell vars
set -x PATH $HOME/.cargo/bin $PATH
if type -q cargo
    set -Ux CARGO_NAME mjarkk
    set -Ux CARGO_EMAIL "mkopenga@gmail.com"

    alias rusup='rustup update'
end

if type -q zoxide
    zoxide init fish | source
end

# On some linux distro's there is a popup for filling in the gpg passphrase and i don't like that
set -Ux GPG_AGENT_INFO ""

# Git config, so i don't have to setup this every time
set -Ux GIT_AUTHOR_NAME mjarkk
set -Ux GIT_AUTHOR_EMAIL "mkopenga@gmail.com"

# Disable analytics for some programs
set -Ux NEXT_TELEMETRY_DISABLED 1 # Next.js

# Use nvim everywhere
if type -q nvim
    set -Ux EDITOR nvim
    set -Ux GIT_EDITOR nvim
    alias vi="nvim"
    alias vim="nvim"
else
    set -Ux EDITOR nano
end

# some distros install the open source edition of vs-code, bind that to code if that's the case
if type -q code-oss
    alias code='code-oss'
end

if test -d ~/.antigravity/antigravity
   set -x PATH $HOME/.antigravity/antigravity/bin $PATH
end

# Some general shotcuts for programs
alias lg='lazygit'
alias ss='sudo systemctl'
alias c='code ./'

function open
    if uname | grep Darwin >/dev/null
        /usr/bin/open $argv
    else
        xdg-open $argv
    end
end

# Shortcut to untar something
alias untar='tar xvzf'

# Git shortcuts
alias branch="git for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"
alias git-stat='git diff --stat' # Show some nice git stats
alias gitstat='git-stat'
alias gitStat='git-stat'
function fuckit
    git add .
    git commit --amend --no-edit
    git push -f
end

# easially find all systems ips
alias ips='ip addr | grep "\([0-9]\{1,3\}\.\)\{3\}\([0-9]\{1,3\}\)" | sed -e "s/^[ \t]*//" | grep -v "127\.0\.0\.1"'

# Bind cat to bat -p, this makes using cat sooo much better
if type -q bat
    alias cat='bat -p'
end
if type -q batcat
    alias cat='batcat -p'
end

# Alias zeditor to zed
if type -q zeditor
    alias zed='zeditor'
end

# Bind ls to exa or eza, they has some nice things that make using ls just a bit better
if type -q exa
    alias ls='exa'
end
if type -q eza
    alias ls='eza'
end

# Set a docker alias to podman as most docker commands work with podman
if type -q podman
    alias docker='podman'
end

function darkTheme
    set -Ux BAT_THEME Monokai Extended
end

function lightTheme
    set -Ux BAT_THEME Monokai Extended Light
end

# By default use the dark theme
darkTheme

if uname | grep Darwin >/dev/null
    # Macos spesific stuff
    set -x PATH /usr/local/opt/php@7.4/bin $PATH
    set -x PATH /usr/local/opt/rabbitmq/sbin $PATH

    alias startMongo='brew services start mongodb-community@5.0'
    alias stopMongo='brew services stop mongodb-community'
    alias startRedis='redis-server /usr/local/etc/redis.conf'
    alias startPostgres='brew services run postgresql'
    alias stopPostgres='brew services restart postgresql'
    function brewup
        brew update
        brew upgrade
    end

    # Set light theme if dark theme is not set in macos
    if not defaults read -g AppleInterfaceStyle 2> /dev/null
        lightTheme
    end
else if test -e /etc/os-release
    # Linux stuff
    alias memoryspeed='sudo lshw -short -C memory | grep "DIMM"'
    alias bios='ss reboot --firmware-setup'
    alias startDocker='ss start docker'

    alias eoup='sudo eopkg upgrade'
    alias pacup='sudo pacman -Syuu --noconfirm'
    alias yayup='yay -Syuu --answerdiff None --answeredit None --answerclean None'
    alias dnfup='sudo dnf update -y'
    alias xbpsup='sudo xbps-install -Syu'
    alias flatup='flatpak update -y'
    function aptup
        sudo apt update -y
        sudo apt upgrade -y
        sudo apt autoremove -y
    end

    if test -e ~/go/bin/mouseless
        alias nomouse='sudo ~/go/bin/mouseless --config ~/Documents/dotfiles/mouseless/config.yaml'
    end
end

function up
    if uname | grep Darwin >/dev/null
        # Macos
        brewup
    else
        # This is a linux distro
        set ID_LIKE (grep "^ID_LIKE=" /etc/os-release | sed 's/ID_LIKE=//' | sed 's/"//g')
        set ID (grep "^ID=" /etc/os-release | sed 's/ID=//' | sed 's/"//g')

        if [ $ID = arch ] || [ $ID_LIKE = arch ]
            if type -q yay
                yayup
            else
                pacup
            end
        else if [ $ID_LIKE = 'ubuntu debian' ] || [ $ID_LIKE = debian ] || [ $ID_LIKE = ubuntu ] || [ $ID = ubuntu ] || [ $ID = debian ]
            aptup
        else if [ $ID = solus ] || [ $ID_LIKE = solus ]
            eoup
        else if [ $ID = void ] || [ $ID_LIKE = void ]
            xbpsup
        else if [ $ID = fedora ] || [ $ID_LIKE = fedora ]
            dnfup
        else
            echo 'Unknown distro: $ID'
        end
    end

    # Also check for flatpak and rust updates if installed
    if type -q flatpak
        flatup
    end
    if type -q rustup
        rusup
    end
    if type -q flutter
        flutter upgrade
    end
end

# For running minio in a development envourment
# I don't like wasting cpu power nor do i want to have a program i don't usually use running in the background.
# That's why i use it this way, now i can start it in a terminal tab and never forget that some bs is running in the background.
alias startMinio='docker run -e "MINIO_ACCESS_KEY=BByNC8gT7WEaT5QOJLHhwBywds8e4iSaZSrwduhsm" -e "MINIO_SECRET_KEY=BcJKJBTxw8YLg9ouEETQXywTCZkxeXz28GYmAYW7R" -it --rm -p 9000:9000 --name minio -v /mnt/data:/data minio/minio server /data'

# Run minio locally
function startMinioLocal
    export MINIO_ACCESS_KEY="BByNC8gT7WEaT5QOJLHhwBywds8e4iSaZSrwduhsm"
    export MINIO_SECRET_KEY="BcJKJBTxw8YLg9ouEETQXywTCZkxeXz28GYmAYW7R"

    export MINIO_ROOT_USER="BByNC8gT7WEaT5QOJLHhwBywds8e4iSaZSrwduhsm"
    export MINIO_ROOT_PASSWORD="BcJKJBTxw8YLg9ouEETQXywTCZkxeXz28GYmAYW7R"

    minio server ~/.minio_data
end

function start_meilisearch
  meilisearch --master-key Rk5Tv0f8wPD07RVksZvDDnceLvEEtSbT56plG78UQ --db-path /Users/mark/.data.ms
end

# Below is the nai shell config:
function _git_branch_name
  echo (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
end

function _git_dirty
  echo (command git status -s --ignore-submodules=dirty 2> /dev/null)
end

function fish_prompt
  set -l yellow (set_color yellow)
  set -l green (set_color green)
  set -l normal (set_color normal)

  set -l cwd (basename (prompt_pwd))

  echo -e ""

  echo -n -s ' ' $cwd $normal

  if [ (_git_branch_name) ]
    set -l git_branch (_git_branch_name)

    if [ (_git_dirty) ]
      set git_info $yellow $git_branch
    else
      set git_info $green $git_branch
    end
    echo -n -s ' ' $git_info $normal
  end

  echo -n -s ' ' $normal
end
