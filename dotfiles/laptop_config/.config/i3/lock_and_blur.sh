#!/usr/bin/env bash

#Script from http://www.michaelabrahamsen.com/posts/custom-lockscreen-i3lock/
#Lock icon from http://www.iconarchive.com/show/flat-finance-icons-by-graphicloads/lock-icon.html

# set the icon and a temporary location for the screenshot to be stored
icon="$HOME/.config/i3/lock-icon.png"
tmpbg='/tmp/screen.png'

# take a screenshot
scrot "$tmpbg"

# blur the screenshot by resizing and scaling back up
convert "$tmpbg" -filter Gaussian -thumbnail 20% -sample 500% "$tmpbg"

# Enable compton's fade-in effect so that the lockscreen gets a nice fade-in
# effect.
dbus-send --print-reply --dest=com.github.chjj.compton.${DISPLAY/:/_} / com.github.chjj.compton.opts_set string:no_fading_openclose boolean:false
dbus-send --print-reply --dest=com.github.chjj.compton.${DISPLAY/:/_} / com.github.chjj.compton.opts_set string:no_fading_openclose boolean:false

# overlay the icon onto the screenshot

# Single monitor
#convert "$tmpbg" "$icon" -gravity center -composite "$tmpbg"

# Multiple monitors
screen1_width=1920
screen1_height=1080
screen1_offsetx=$(expr $screen1_width / 2 - 256 / 2)
screen1_offsety=$(expr $screen1_height / 2 - 256 / 2)

screen2_width=1280
screen2_height=1024
screen2_offsetx=$(expr $screen1_width + $screen2_width / 2 - 256 / 2)
screen2_offsety=$(expr $screen2_height / 2 - 256 / 2)

convert "$tmpbg" "$icon" -geometry +$screen1_offsetx+$screen1_offsety -composite "$tmpbg"
convert "$tmpbg" "$icon" -geometry +$screen2_offsetx+$screen2_offsety -composite "$tmpbg"

# lock the screen with the blurred screenshot
pkill -u $USER -USR1 dunst

i3lock -n -i "$tmpbg" \
    --insidecolor=43454dff --ringcolor=686a70ff --line-uses-inside \
    --keyhlcolor=4f3a77ff --bshlcolor=bd3246ff --separatorcolor=00000000 \
    --insidevercolor=917ebfff --insidewrongcolor=bd3246ff \
    --ringvercolor=43454dff --ringwrongcolor=8d0033ff --indpos="x+86:y+1003" \
    --radius=15 --veriftext="" --wrongtext="" --screen=0 --indicator
pkill -u $USER -USR2 dunst


dbus-send --print-reply --dest=com.github.chjj.compton.${DISPLAY/:/_} / com.github.chjj.compton.opts_set string:no_fading_openclose boolean:true