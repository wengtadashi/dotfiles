# 🏠 Dotfiles

My personal dotfiles configuration for a productive development environment. This repository contains configurations for:

- 🚀 **Neovim** - Modern text editor with LSP, completion, and plugins
- 🐚 **Zsh** - Enhanced shell with oh-my-zsh and useful plugins
- 🛠️ **Oh-My-Zsh** - Framework for managing zsh configuration
- 📺 **Tmux** - Terminal multiplexer for session management

## ✨ Features

### Neovim Configuration
- **Plugin Management**: Using lazy.nvim for fast plugin loading
- **LSP Support**: Language servers for Lua, Rust, TypeScript, and more
- **Autocompletion**: nvim-cmp with multiple sources
- **Fuzzy Finding**: Telescope for file and text search
- **Syntax Highlighting**: Treesitter for enhanced syntax highlighting
- **File Explorer**: nvim-tree for project navigation
- **Git Integration**: Gitsigns for git status in editor
- **Theme**: Catppuccin colorscheme

### Zsh Configuration
- **Theme**: Agnoster theme for a clean prompt
- **Plugins**: Essential plugins including autosuggestions and syntax highlighting
- **Aliases**: Comprehensive set of useful aliases for development
- **Functions**: Custom functions for common tasks
- **History**: Enhanced history management
- **Completions**: Smart tab completion

### Tmux Configuration
- **Prefix Key**: Changed to Ctrl-a (more ergonomic)
- **Mouse Support**: Full mouse integration
- **Vim Keybindings**: Familiar navigation keys
- **Plugin Manager**: TPM with useful plugins
- **Status Bar**: Informative status line
- **Session Management**: Automatic session saving and restoration

## 🚀 Quick Start

### Prerequisites

Make sure you have the following installed:
- `git`
- `curl`
- `zsh`
- `tmux`
- `neovim` (latest version recommended)

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/wengtadashi/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. **Run the installation script**:
   ```bash
   ./scripts/install.sh
   ```

3. **Restart your terminal or reload zsh**:
   ```bash
   source ~/.zshrc
   ```

4. **Install tmux plugins**:
   - Start tmux: `tmux`
   - Press `Ctrl-a + I` to install plugins

5. **Open Neovim**:
   ```bash
   nvim
   ```
   - Plugins will install automatically on first run

## 📁 Repository Structure

```
dotfiles/
├── nvim/                    # Neovim configuration
│   ├── init.lua            # Main configuration file
│   └── lua/config/
│       └── plugins.lua     # Plugin specifications
├── zsh/                    # Zsh configuration
│   ├── .zshrc             # Main zsh configuration
│   └── .zsh_aliases       # Additional aliases
├── tmux/                   # Tmux configuration
│   └── .tmux.conf         # Tmux configuration file
├── scripts/                # Installation scripts
│   ├── install.sh         # Installation script
│   └── uninstall.sh       # Uninstallation script
└── README.md              # This file
```

## ⚙️ Customization

### Adding Local Configurations

You can add machine-specific configurations without modifying the main files:

- **Zsh**: Create `~/.zshrc.local` for local zsh configuration
- **Neovim**: Add custom configurations in the `after/` directory
- **Tmux**: Source additional configurations in `.tmux.conf`

### Modifying Configurations

1. Edit the files in this repository
2. The changes will be reflected immediately (symlinks)
3. Commit your changes to keep them in version control

## 🛠️ Key Bindings

### Neovim
- `<Space>` - Leader key
- `<Leader>pv` - Open file explorer
- `<Leader>pf` - Find files
- `<Ctrl-p>` - Git files
- `<Leader>ps` - Live grep
- `<Leader>e` - Toggle nvim-tree

### Tmux
- `Ctrl-a` - Prefix key
- `Ctrl-a |` - Split vertically
- `Ctrl-a -` - Split horizontally
- `Ctrl-a h/j/k/l` - Navigate panes
- `Alt-Arrow` - Navigate panes (no prefix)
- `Shift-Arrow` - Navigate windows (no prefix)

### Zsh
- `Ctrl-R` - Reverse history search
- `Ctrl-A` - Beginning of line
- `Ctrl-E` - End of line

## 🔧 Troubleshooting

### Neovim Issues
- Ensure you have the latest version of Neovim (0.8+)
- Install `ripgrep` and `fd` for better telescope performance
- Check `:checkhealth` in Neovim for diagnostics

### Zsh Issues
- Make sure zsh is your default shell: `chsh -s $(which zsh)`
- If plugins don't work, check if they're properly installed in `~/.oh-my-zsh/custom/plugins/`

### Tmux Issues
- Ensure tmux version is 2.1 or later
- If plugins don't work, install TPM manually and run `Ctrl-a + I`

## 🗑️ Uninstallation

To remove the dotfiles configuration:

```bash
./scripts/uninstall.sh
```

This will:
- Remove all symlinks
- Restore backed up files (if any)
- Leave installed dependencies intact

## 📝 License

This project is open source and available under the [MIT License](LICENSE).

## 🤝 Contributing

Feel free to fork this repository and customize it for your own use. If you have improvements or suggestions, pull requests are welcome!

---

**Happy coding!** 🚀