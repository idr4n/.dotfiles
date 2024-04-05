import os

# import subprocess
import darkdetect

# Neovim
light_nvim = "github_light"
dark_nvim = "catppuccin-mocha"

# Kitty
light_color_kitty = "Github Light"
dark_color_kitty = "Catppuccin-Mocha"

# Alacritty
light_color_alacritty = "github_light"
# light_color_alacritty = "rose-pine-dawn"
# dark_color_alacritty = "tokyo_night_moon"
# dark_color_alacritty = "catppuccin-macchiato"
dark_color_alacritty = "catppuccin-mocha"

if os.environ.get("HOME") == "/Users/iduran":
    if darkdetect.isDark():
        os.system(
            f"/opt/homebrew/bin/kitty +kitten themes --reload-in=all {dark_color_kitty}"
        )
        os.system(
            f"{os.environ.get('HOME')}/bin/alacritty-theme {dark_color_alacritty}"
        )
        os.system(f"{os.environ.get('HOME')}/dotfiles/scripts/nvim_change_colorscheme {dark_nvim}")
    else:
        os.system(
            "/opt/homebrew/bin/kitty +kitten themes --reload-in=all"
            f" {light_color_kitty}"
        )
        os.system(
            f"{os.environ.get('HOME')}/bin/alacritty-theme {light_color_alacritty}"
        )
        os.system(f"{os.environ.get('HOME')}/dotfiles/scripts/nvim_change_colorscheme {light_nvim}")

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
