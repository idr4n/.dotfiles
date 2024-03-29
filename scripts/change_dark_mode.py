import os

# import subprocess
import darkdetect

# nvim_servers = subprocess.getoutput(
#     "/opt/homebrew/bin/fd . --type s ${XDG_RUNTIME_DIR:-${TMPDIR}nvim.${USER}}/"
# ).split("\n")

light_helix = "mono_light"
dark_helix = "mono_dark"
# light_color_kitty = "Zenbones Light Custom"
# light_color_kitty = "nordfox"
# light_color_kitty = "Catppuccin-Frappe"
# light_color_kitty = "Catppuccin-Macchiato"
# light_color_kitty = "Tokyo Night Storm"
# light_color_kitty = "Tokyo Night Moon"
light_color_kitty = "Github Light"
# light_color_kitty = "Tokyo Night Custom"
# dark_color_kitty = "Tokyo Night Custom"
# light_color_kitty = "Rose Pine Moon"
# dark_color_kitty = "Rose Pine"
# dark_color_kitty = "Tokyo Night Storm"
# dark_color_kitty = "Tokyo Night Moon"
# dark_color_kitty = "Rose Pine Moon"
# dark_color_kitty = "Catppuccin-Macchiato"
# dark_color_kitty = "Nord Custom"
dark_color_kitty = "Zenbones Dark Custom"
# dark_color_kitty = "nightfly"
# dark_color_kitty = "duskfox"
# dark_color_kitty = "Rasmus"
# light_color_alacritty = "zenbones_light"
# light_color_alacritty = "nordfox"
# light_color_alacritty = "catppuccin-frappe"
# light_color_alacritty = "catppuccin-macchiato"
# light_color_alacritty = "tokyo_night_storm"
# light_color_alacritty = "tokyo_night_moon"
light_color_alacritty = "github_light"
# light_color_alacritty = "rose-pine-dawn"
# light_color_alacritty = "oxocarbon"
# dark_color_alacritty = "tokyo_night"
# dark_color_alacritty = "tokyo_night_storm"
# dark_color_alacritty = "tokyo_night_moon"
# dark_color_alacritty = "rose-pine-moon"
# dark_color_alacritty = "catppuccin-macchiato"
# dark_color_alacritty = "oxocarbon"
dark_color_alacritty = "zenbones_dark"
# dark_color_alacritty = "nightfly"
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
        os.system(
            f"{os.environ.get('HOME')}/.config/helix/helix-theme {dark_helix}"
        )

        # for server in nvim_servers:
        #     os.system(
        #         f'/opt/homebrew/bin/nvim --server {server} --remote-send ":colorscheme'
        #         ' tokyonight-moon<cr>"'
        #     )

    else:
        os.system(
            "/opt/homebrew/bin/kitty +kitten themes --reload-in=all"
            f" {light_color_kitty}"
        )
        os.system(
            f"{os.environ.get('HOME')}/bin/alacritty-theme {light_color_alacritty}"
        )
        os.system(
            f"{os.environ.get('HOME')}/.config/helix/helix-theme {light_helix}"
        )

        # for server in nvim_servers:
        #     os.system(
        #         f'/opt/homebrew/bin/nvim --server {server} --remote-send ":colorscheme'
        #         ' github_light<cr>"'
        #     )

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
