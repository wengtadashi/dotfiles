#!/bin/bash

# Dependency Check Script
# Checks if required tools are installed

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔍 Checking dependencies for dotfiles...${NC}"
echo ""

# Function to check if command exists
check_command() {
    local cmd="$1"
    local name="$2"
    local optional="$3"
    
    if command -v "$cmd" >/dev/null 2>&1; then
        local version=$(eval "$cmd --version 2>/dev/null | head -1" || echo "version unknown")
        echo -e "${GREEN}✅ $name is installed${NC} ($version)"
        return 0
    else
        if [ "$optional" = "optional" ]; then
            echo -e "${YELLOW}⚠️  $name is not installed (optional)${NC}"
            return 1
        else
            echo -e "${RED}❌ $name is not installed (required)${NC}"
            return 1
        fi
    fi
}

# Check required dependencies
echo -e "${BLUE}📋 Required dependencies:${NC}"
required_missing=0

check_command "git" "Git" || required_missing=$((required_missing + 1))
check_command "curl" "Curl" || required_missing=$((required_missing + 1))
check_command "zsh" "Zsh" || required_missing=$((required_missing + 1))

echo ""
echo -e "${BLUE}📋 Recommended dependencies:${NC}"
optional_missing=0

check_command "nvim" "Neovim" "optional" || optional_missing=$((optional_missing + 1))
check_command "tmux" "Tmux" "optional" || optional_missing=$((optional_missing + 1))
check_command "rg" "Ripgrep" "optional" || optional_missing=$((optional_missing + 1))
check_command "fd" "fd" "optional" || optional_missing=$((optional_missing + 1))
check_command "node" "Node.js" "optional" || optional_missing=$((optional_missing + 1))

echo ""

if [ $required_missing -eq 0 ]; then
    echo -e "${GREEN}🎉 All required dependencies are installed!${NC}"
    if [ $optional_missing -gt 0 ]; then
        echo -e "${YELLOW}💡 Consider installing the optional dependencies for the best experience.${NC}"
    fi
    echo ""
    echo -e "${BLUE}🚀 You're ready to run: ./scripts/install.sh${NC}"
else
    echo -e "${RED}❌ Please install the missing required dependencies before proceeding.${NC}"
    echo ""
    echo -e "${BLUE}📦 Installation suggestions:${NC}"
    echo -e "   ${YELLOW}Ubuntu/Debian:${NC} sudo apt update && sudo apt install git curl zsh tmux neovim ripgrep fd-find nodejs npm"
    echo -e "   ${YELLOW}macOS:${NC} brew install git curl zsh tmux neovim ripgrep fd node"
    echo -e "   ${YELLOW}Arch Linux:${NC} sudo pacman -S git curl zsh tmux neovim ripgrep fd nodejs npm"
    exit 1
fi