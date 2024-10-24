DOTFILES_DIR := $(HOME)/dotfiles
CONFIG_DIR := $(HOME)/.config

DOTFILE_TARGETS := git alacritty nvim typst

.PHONY: all
all: homebrew dotfiles

.PHONY: homebrew
homebrew:
	@echo "Installing Homebrew packages..."
	@if ! command -v brew >/dev/null; then \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	fi
	@brew bundle --file=$(DOTFILES_DIR)/Brewfile

.PHONY: dotfiles
dotfiles: $(DOTFILE_TARGETS)

.PHONY: git
git:
	@echo "Setting up git configuration..."
	@ln -vsf $(DOTFILES_DIR)/.gitignore $(HOME)

.PHONY: alacritty
alacritty:
	@echo "Setting up Alacritty configuration..."
	@ln -vsnf $(DOTFILES_DIR)/.config/alacritty $(CONFIG_DIR)

.PHONY: nvim
nvim:
	@echo "Setting up Neovim configuration..."
	@if [ ! -d "$(CONFIG_DIR)/nvim" ]; then \
		git clone https://github.com/idr4n/nvim-lua.git $(CONFIG_DIR)/nvim; \
	else \
		echo "Neovim configuration already exists. Updating..."; \
		cd $(CONFIG_DIR)/nvim && git pull; \
	fi

.PHONY: latexmkrc
latexmkrc:
	@echo "Setting up latexmkrc..."
	@ln -vsf $(DOTFILES_DIR)/.latexmkrc $(HOME)

.PHONY: typst
typst:
	@echo "Setting up Typst configuration..."
	@ln -vsf $(DOTFILES_DIR)/typst $(HOME)

.PHONY: list
list:
	@echo "Installed Homebrew packages:"
	@brew leaves --full-name
	@echo "\nInstalled Cask applications:"
	@brew list --cask
