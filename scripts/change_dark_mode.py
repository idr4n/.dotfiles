import os

# import subprocess
import darkdetect

# Neovim
# light_nvim = "onedark"
# light_nvim = "dracula"
# light_nvim = "tokyonight"
# light_nvim = "nord"
# light_nvim = "github_light"
# light_nvim = "github-monochrome-light"
# light_nvim = "github-monochrome-rosepine-dawn"
light_nvim = "gruvbox-material"
# light_nvim = "jellybeans"
# dark_nvim = "tokyonight"
# dark_nvim = "github-monochrome-dark"
# dark_nvim = "github-monochrome-zenbones"
# dark_nvim = "cyberdream"
# dark_nvim = "nord"
# dark_nvim = "github-monochrome-solarized"
dark_nvim = "gruvbox-material"
# dark_nvim = "jellybeans"
# dark_nvim = "onedark"
# dark_nvim = "dracula"
# dark_nvim = "zenbones"

# Kitty
# light_color_kitty = "Nord Custom"
# light_color_kitty = "Tokyo Night Custom"
# light_color_kitty = "Tokyo Night Moon"
# light_color_kitty = "github_monochrome_light"
# light_color_kitty = "github_monochrome_rosepine-dawn"
# light_color_kitty = "Onedark"
# light_color_kitty = "dracula"
light_color_kitty = "Gruvbox Material Dark Hard"
# dark_color_kitty = "Solarized"
# dark_color_kitty = "github_monochrome_dark"
# dark_color_kitty = "Zenbones Dark Custom"
# dark_color_kitty = "cyberdream"
# dark_color_kitty = "Nord Custom"
# dark_color_kitty = "Gruvbox Dark Hard"
dark_color_kitty = "Gruvbox Material Dark Hard"
# dark_color_kitty = "Tokyo Night Custom"
# dark_color_kitty = "Onedark"
# dark_color_kitty = "dracula"

# Alacritty
# light_color_alacritty = "github_monochrome_light"
# light_color_alacritty = "rose-pine-dawn"
light_color_alacritty = "gruvbox_dark"
# light_color_alacritty = "tokyonight_night"
# light_color_alacritty = "one_dark"
# light_color_alacritty = "nord"
# light_color_alacritty = "dracula"
# dark_color_alacritty = "tokyo_night_moon"
# dark_color_alacritty = "tokyonight_night"
# dark_color_alacritty = "github_monochrome_dark"
dark_color_alacritty = "gruvbox_dark"
# dark_color_alacritty = "one_dark"
# dark_color_alacritty = "dracula"
# dark_color_alacritty = "catppuccin-mocha"
# dark_color_alacritty = "zenbones_dark"
# dark_color_alacritty = "cyberdream"
# dark_color_alacritty = "nord"

# ghostty
# light_color_ghostty = "nord"
# light_color_ghostty = "dracula"
# light_color_ghostty = "github_light_custom"
# light_color_ghostty = "rose-pine-dawn"
# light_color_ghostty = "github_monochrome_light"
light_color_ghostty = "gruvbox_dark_hard_custom"
# light_color_ghostty = "jellybeans_custom"
# light_color_ghostty = "tokyonight"
# light_color_ghostty = "OneDark"
# dark_color_ghosty = "zenbones_dark"
# dark_color_ghosty = "kanso-zen"
# dark_color_ghosty = "dracula"
# dark_color_ghosty = "tokyonight"
# dark_color_ghosty = "github_monochrome_dark"
# dark_color_ghosty = "zenbones_dark_custom"
# dark_color_ghosty = "cyberdream"
# dark_color_ghosty = "nord"
# dark_color_ghosty = "OneDark"
dark_color_ghosty = "gruvbox_dark_hard_custom"
# dark_color_ghosty = "jellybeans_custom"

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
