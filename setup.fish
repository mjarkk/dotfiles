#!/usr/bin/fish

# Get omf and install a theme i like together with copying my config
curl -L https://get.oh-my.fish | fish
omf install nai
cp init.fish ~/.config/omf/init.fish

if type -q code
  cp vscode/keybindings.json ~/.config/Code/User/keybindings.json
  cp vscode/settings.json ~/.config/Code/User/settings.json
end
