#!/bin/bash
# exit when any command fails
set -e

# Install Oh My ZSH
if [[ ! -e ~/.oh-my-zsh ]]; then
    echo "[*] Ready to install Oh-My-Zsh"
    echo "[!] Please re-run this script after Oh-My-Zsh is installed."
    read -p "Press Enter key to continue..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    exit
fi


# Install fonts
echo "[*] Downloading fonts (MesloLGS NF)..."
wget -P $HOME/Library/Fonts/ https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Regular.ttf
wget -P $HOME/Library/Fonts/ https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Bold.ttf
wget -P $HOME/Library/Fonts/ https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Italic.ttf
wget -P $HOME/Library/Fonts/ https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Bold%20Italic.ttf


# Configure Hyper preferences
echo "[*] Configuring HyperTerminal..."
# Change default font
sed -i '' "s/fontFamily: '/fontFamily: '\"MesloLGS NF\", /g" ~/.hyper.js
# Disable WebGL Rendering
sed -i '' "s/webGLRenderer: true/webGLRenderer: false/g" ~/.hyper.js
# Change theme to OneDark
sed -i '' 's/plugins: .*/plugins: \[`hyperterm-atom-dark`\],/g' ~/.hyper.js


# Install PowerLevel10K
echo "[*] Installing PowerLevel10K..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
sed -i '' "s/^ZSH_THEME.*/ZSH_THEME=powerlevel10k\/powerlevel10k/g" ~/.zshrc


# Remove % sign when starting SHELL
echo "unsetopt PROMPT_SP" >> ~/.zshrc


# Install Oh-My-ZSH plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
sed -i '' "s/^plugins=(.*)$/plugins=(git python docker osx zsh-autosuggestions)/g" ~/.zshrc