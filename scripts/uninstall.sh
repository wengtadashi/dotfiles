#!/bin/bash

# Dotfiles Uninstallation Script
# This script will remove symlinks and restore backups if available

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🗑️  Starting dotfiles uninstallation...${NC}"

# Function to remove symlink and restore backup
remove_symlink_and_restore() {
    local target="$1"
    
    if [ -L "$target" ]; then
        echo -e "${YELLOW}🔗 Removing symlink: $target${NC}"
        rm "$target"
        
        # Look for backup files and restore the most recent one
        local backup_pattern="${target}.backup.*"
        local latest_backup=$(ls -t $backup_pattern 2>/dev/null | head -n1)
        
        if [ -n "$latest_backup" ] && [ -f "$latest_backup" ]; then
            mv "$latest_backup" "$target"
            echo -e "${GREEN}📦 Restored backup: $latest_backup -> $target${NC}"
        fi
    elif [ -e "$target" ]; then
        echo -e "${YELLOW}⚠️  $target is not a symlink, skipping...${NC}"
    else
        echo -e "${BLUE}ℹ️  $target does not exist, skipping...${NC}"
    fi
}

echo -e "${BLUE}🔗 Removing symlinks...${NC}"

# Remove configuration symlinks
remove_symlink_and_restore "$HOME/.config/nvim"
remove_symlink_and_restore "$HOME/.zshrc"
remove_symlink_and_restore "$HOME/.zsh_aliases"
remove_symlink_and_restore "$HOME/.tmux.conf"

echo -e "${YELLOW}⚠️  Note: The following were not removed (manual removal required if desired):${NC}"
echo -e "   - Oh My Zsh installation (~/.oh-my-zsh)"
echo -e "   - ZSH plugins (~/.oh-my-zsh/custom/plugins/)"
echo -e "   - Tmux Plugin Manager (~/.tmux/plugins/tpm)"
echo -e "   - Neovim plugins (~/.local/share/nvim)"
echo ""
echo -e "${GREEN}🎉 Dotfiles uninstallation completed!${NC}"
echo -e "${BLUE}💡 Backup files (if any) have been restored.${NC}"