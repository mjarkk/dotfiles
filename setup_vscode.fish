#!/usr/bin/fish

if type -q code
  cp vscode/keybindings.json ~/.config/Code/User/keybindings.json
  cp vscode/settings.json ~/.config/Code/User/settings.json
else
  echo "Code command not defined"
end
