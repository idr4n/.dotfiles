import os

# import subprocess
import darkdetect

# Neovim
# light_nvim = "onedark"
# light_nvim = "tokyonight"
light_nvim = "nord"
# light_nvim = "github_light"
# dark_nvim = "tokyonight"
# dark_nvim = "onedark"
dark_nvim = "dracula"
# dark_nvim = "nord"

# Kitty
light_color_kitty = "dracula"
# light_color_kitty = "Tokyo Night Moon"
# light_color_kitty = "Github Light"
# light_color_kitty = "Onedark"
# dark_color_kitty = "Tokyo Night Moon"
# dark_color_kitty = "Onedark"
dark_color_kitty = "dracula"

# Alacritty
# light_color_alacritty = "github_light"
# light_color_alacritty = "one_dark"
light_color_alacritty = "nord"
# light_color_alacritty = "tokyo_night_moon"
# dark_color_alacritty = "tokyo_night_moon"
# dark_color_alacritty = "one_dark"
dark_color_alacritty = "dracula"
# dark_color_alacritty = "nord"

# ghostty
light_color_ghostty = "nord"
dark_color_ghosty = "dracula"

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
