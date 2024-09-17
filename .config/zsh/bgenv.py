import sys
import darkdetect

bg_light = "#3C435D"
bg_dark = "#2E3347"

if darkdetect.isDark():
    print(bg_dark, end="")
else:
    print(bg_light, end="")

sys.exit(0)
