import sys
import darkdetect

bg_light = "#282A36"  # dracula
# bg_dark = "#222436" # tokyonight moon
bg_dark = "#282A36"  # dracual

if darkdetect.isDark():
    print(bg_dark, end="")
else:
    print(bg_light, end="")

sys.exit(0)
