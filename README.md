# dotfiles
This repo contains all my config files

Peek around to see what you like to use,
I won't tell how i setup this all because it might break things.


Setup fish
```bash
# oh my fish
curl -L https://get.oh-my.fish | fish
omf install nai
cp init.fish ~/.config/omf/init.fish

# fnm a node version manager
curl -fsSL https://fnm.vercel.app/install | bash
fnm install 15
fnm use 15
```
