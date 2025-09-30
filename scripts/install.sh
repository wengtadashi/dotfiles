#!/bin/bash

# Dotfiles Installation Script
# This script will set up symlinks for all dotfiles configurations

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"

echo -e "${BLUE}🚀 Starting dotfiles installation...${NC}"

# Function to create symlink
create_symlink() {
    local source="$1"
    local target="$2"
    
    # Create target directory if it doesn't exist
    mkdir -p "$(dirname "$target")"
    
    # Remove existing file/symlink if it exists
    if [ -e "$target" ] || [ -L "$target" ]; then
        echo -e "${YELLOW}⚠️  Removing existing $target${NC}"
        rm -rf "$target"
    fi
    
    # Create symlink
    ln -sf "$source" "$target"
    echo -e "${GREEN}✅ Created symlink: $target -> $source${NC}"
}

# Function to backup existing files
backup_existing() {
    local file="$1"
    if [ -e "$file" ] && [ ! -L "$file" ]; then
        local backup="$file.backup.$(date +%Y%m%d_%H%M%S)"
        mv "$file" "$backup"
        echo -e "${YELLOW}📦 Backed up existing file: $file -> $backup${NC}"
    fi
}

echo -e "${BLUE}📋 Setting up configuration files...${NC}"

# Backup existing files
backup_existing "$HOME/.zshrc"
backup_existing "$HOME/.tmux.conf"
backup_existing "$HOME/.config/nvim"

# Create necessary directories
mkdir -p "$HOME/.config"

# Create symlinks
echo -e "${BLUE}🔗 Creating symlinks...${NC}"

# Neovim configuration
create_symlink "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

# ZSH configuration
create_symlink "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
create_symlink "$DOTFILES_DIR/zsh/.zsh_aliases" "$HOME/.zsh_aliases"

# Tmux configuration
create_symlink "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"

echo -e "${BLUE}📦 Installing dependencies...${NC}"

# Install oh-my-zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo -e "${YELLOW}📥 Installing Oh My Zsh...${NC}"
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo -e "${GREEN}✅ Oh My Zsh is already installed${NC}"
fi

# Install zsh plugins
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

# zsh-autosuggestions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    echo -e "${YELLOW}📥 Installing zsh-autosuggestions...${NC}"
    git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
else
    echo -e "${GREEN}✅ zsh-autosuggestions is already installed${NC}"
fi

# zsh-syntax-highlighting
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    echo -e "${YELLOW}📥 Installing zsh-syntax-highlighting...${NC}"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
else
    echo -e "${GREEN}✅ zsh-syntax-highlighting is already installed${NC}"
fi

# Install tmux plugin manager
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo -e "${YELLOW}📥 Installing Tmux Plugin Manager...${NC}"
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
else
    echo -e "${GREEN}✅ Tmux Plugin Manager is already installed${NC}"
fi

echo -e "${GREEN}🎉 Dotfiles installation completed!${NC}"
echo ""
echo -e "${BLUE}📌 Next steps:${NC}"
echo -e "${YELLOW}1. Restart your terminal or run: source ~/.zshrc${NC}"
echo -e "${YELLOW}2. Install tmux plugins by pressing: prefix + I (Ctrl-a + I)${NC}"
echo -e "${YELLOW}3. Open Neovim and let it install plugins automatically${NC}"
echo -e "${YELLOW}4. Consider installing additional tools:${NC}"
echo -e "   - neovim (latest version)"
echo -e "   - tmux"
echo -e "   - ripgrep (for telescope.nvim)"
echo -e "   - fd (for telescope.nvim)"
echo -e "   - node.js (for LSP servers)"
echo ""
echo -e "${GREEN}Happy coding! 🚀${NC}"