import os
import darkdetect

# light_color_kitty = "Zenbones Light Custom"
# light_color_kitty = "nordfox"
# light_color_kitty = "Catppuccin-Frappe"
# light_color_kitty = "Tokyo Night Storm"
# dark_color_kitty = "Tokyo Night Custom"
light_color_kitty = "Rose Pine Moon"
dark_color_kitty = "Rose Pine"
# dark_color_kitty = "Tokyo Night Storm"
# dark_color_kitty = "Catppuccin-Macchiato"
# dark_color_kitty = "Nord Custom"
# dark_color_kitty = "Zenbones Dark Custom"
# dark_color_kitty = "duskfox"
# dark_color_kitty = "Rasmus"
# light_color_alacritty = "zenbones_light"
# light_color_alacritty = "nordfox"
light_color_alacritty = "catppuccin-frappe"
# light_color_alacritty = "tokyo_night_storm"
# dark_color_alacritty = "tokyo_night"
# dark_color_alacritty = "tokyo_night_storm"
dark_color_alacritty = "catppuccin-macchiato"
# dark_color_alacritty = "zenbones_dark"
# dark_color_alacritty = "duskfox"
# dark_color_alacritty = "rasmus"

if os.environ.get("HOME") == "/Users/iduran":
    if darkdetect.isDark():
        os.system(
            f"/opt/homebrew/bin/kitty +kitten themes --reload-in=all {dark_color_kitty}"
        )
        os.system(
            f"{os.environ.get('HOME')}/bin/alacritty-theme {dark_color_alacritty}"
        )
    else:
        os.system(
            f"/opt/homebrew/bin/kitty +kitten themes --reload-in=all {light_color_kitty}"
        )
        os.system(
            f"{os.environ.get('HOME')}/bin/alacritty-theme {light_color_alacritty}"
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
