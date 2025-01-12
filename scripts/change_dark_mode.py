import os

# import subprocess
import darkdetect

# Neovim
# light_nvim = "onedark"
# light_nvim = "dracula"
# light_nvim = "gruvbox-material"
# light_nvim = "tokyonight"
# light_nvim = "nord"
# light_nvim = "catppuccin-mocha"
# light_nvim = "github_light"
light_nvim = "github-monochrome-light"
# dark_nvim = "tokyonight"
dark_nvim = "github-monochrome-dark"
# dark_nvim = "gruvbox-material"
# dark_nvim = "onedark"
# dark_nvim = "dracula"
# dark_nvim = "zenbones"

# Kitty
# light_color_kitty = "Nord Custom"
# light_color_kitty = "Catppuccin-Mocha"
# light_color_kitty = "noirbuddy-slate"
# light_color_kitty = "Tokyo Night Custom"
# light_color_kitty = "Tokyo Night Moon"
light_color_kitty = "Github Light"
# light_color_kitty = "Onedark"
# light_color_kitty = "dracula"
# light_color_kitty = "Gruvbox Material Dark Hard"
dark_color_kitty = "Tokyo Night Custom"
# dark_color_kitty = "Gruvbox Material Dark Hard"
# dark_color_kitty = "Onedark"
# dark_color_kitty = "dracula"
# dark_color_kitty = "Rose Pine"
# dark_color_kitty = "noirbuddy-slate"

# Alacritty
# light_color_alacritty = "github_light"
light_color_alacritty = "github_monochrome_light"
# light_color_alacritty = "one_dark"
# light_color_alacritty = "nord"
# light_color_alacritty = "catppuccin-mocha"
# light_color_alacritty = "noirbuddy-slate"
# light_color_alacritty = "dracula"
# light_color_alacritty = "gruvbox_material_hard_dark"
# dark_color_alacritty = "tokyo_night_moon"
# dark_color_alacritty = "tokyonight_night"
dark_color_alacritty = "github_monochrome_dark"
# dark_color_alacritty = "gruvbox_material_hard_dark"
# dark_color_alacritty = "one_dark"
# dark_color_alacritty = "dracula"
# dark_color_alacritty = "catppuccin-mocha"
# dark_color_alacritty = "noirbuddy-slate"
# dark_color_alacritty = "zenbones_dark"

# ghostty
# light_color_ghostty = "nord"
# light_color_ghostty = "noirbuddy-slate"
# light_color_ghostty = "dracula"
# light_color_ghostty = "github_light_custom"
light_color_ghostty = "github_monochrome_light"
# light_color_ghostty = "gruvbox_dark_hard_custom"
# light_color_ghostty = "tokyonight"
# light_color_ghostty = "OneDark"
# dark_color_ghosty = "zenbones_dark"
# dark_color_ghosty = "dracula"
# dark_color_ghosty = "tokyonight"
dark_color_ghosty = "github_monochrome_dark"
# dark_color_ghosty = "gruvbox_dark_hard_custom"
# dark_color_ghosty = "noirbuddy-slate"

if os.environ.get("HOME") == "/Users/iduran":
    if darkdetect.isDark():
        os.system(
            f"/opt/homebrew/bin/kitty +kitten themes --reload-in=all {dark_color_kitty}"
        )
        os.system(
            f"{os.environ.get('HOME')}/bin/alacritty-theme {dark_color_alacritty}"
        )
        os.system(f"{os.environ.get('HOME')}/bin/ghostty-theme {dark_color_ghosty}")
        os.system(
            f"{os.environ.get('HOME')}/dotfiles/scripts/nvim_change_colorscheme {dark_nvim}"
        )
    else:
        os.system(
            "/opt/homebrew/bin/kitty +kitten themes --reload-in=all"
            f" {light_color_kitty}"
        )
        os.system(
            f"{os.environ.get('HOME')}/bin/alacritty-theme {light_color_alacritty}"
        )
        os.system(f"{os.environ.get('HOME')}/bin/ghostty-theme {light_color_ghostty}")
        os.system(
            f"{os.environ.get('HOME')}/dotfiles/scripts/nvim_change_colorscheme {light_nvim}"
        )

else:
    if darkdetect.isDark():
        os.system(
            f"/usr/local/bin/kitty +kitten themes --reload-in=all {dark_color_kitty}"
        )
        os.system(
            f"{os.environ.get('HOME')}/bin/alacritty-theme {dark_color_alacritty}"
        )
    else:
        os.system(
            f"/usr/local/bin/kitty +kitten themes --reload-in=all {light_color_kitty}"
        )
        os.system(
            f"{os.environ.get('HOME')}/bin/alacritty-theme {light_color_alacritty}"
        )
