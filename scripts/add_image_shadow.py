#!/usr/bin/env python3
import sys
import os
from datetime import datetime as dt
import subprocess as sp
from PIL import ImageGrab

# img_path = sys.argv[1]

# Pull image from clibpoard
img = ImageGrab.grabclipboard()

# create output image name with timestamp
date_time = dt.now()
timestamp = date_time.strftime("%y%m%d-%H%M%S")
img_name = 'image_%s.%s' % (timestamp, 'png')

# files paths
input_file = os.path.join(os.getenv('TMPDIR'), 'image')
output_file = os.path.join(os.getenv('HOME'), 'Desktop/ScreenShots', img_name)

if not os.path.isdir(os.path.dirname(output_file)):
    os.makedirs(output_file)

# convert command
brew_path = sp.getoutput('brew --prefix')
convert_cmd = os.path.join(brew_path, 'bin/convert')

# shadow_cmd = f"""
# /opt/homebrew/bin/convert {file} \( +clone -background black \
# -shadow 80x20+0+15 \) +swap -background transparent -layers merge \
# +repage {file2}
# """
shadow_cmd = f"""
{convert_cmd} {input_file} \( +clone -alpha extract \
\( -size 15x15 xc:black -draw 'fill white circle 15,15 15,0' -write mpr:arc +delete \) \
\( mpr:arc \) -gravity northwest -composite \
\( mpr:arc -flip \) -gravity southwest -composite \
\( mpr:arc -flop \) -gravity northeast -composite \
\( mpr:arc -rotate 180 \) -gravity southeast -composite \) \
-alpha off -compose CopyOpacity -composite -compose over \
\( +clone -background black -shadow 50x20+0+15 \) \
+swap -background none -layers merge {output_file}
"""

copy_to_clipboard = f"""
osascript -e 'set the clipboard to read POSIX file \"{output_file}\" as «class PNGf»'
"""

msg_saved = """
osascript -e 'display notification \"Image saved and copied to clipboard!\" \
with title \"Image Shadow: \"'
"""

msg_no_image = """
osascript -e 'display notification \"No image found in clipboard!\" \
with title \"Image Shadow: \"'
"""

if img:
    img.save(input_file, 'PNG')
    os.system(shadow_cmd)
else:
    os.system(msg_no_image)

if os.path.exists(output_file):
    os.system(copy_to_clipboard)
    os.system(msg_saved)
    # os.system(f"open -R {output_file}")
    os.system(f"rm {input_file}")
    sys.exit(0)

sys.exit(1)
