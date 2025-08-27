#!/bin/bash

colors_file="$HOME/.cache/wal/colors"
generated_dir="$HOME/.config/generated"
mkdir -p "$generated_dir"

mapfile -t colors < "$colors_file"

cat > "$generated_dir/colors-i3-config.conf" <<EOL
client.focused          ${colors[6]} ${colors[0]} ${colors[6]} ${colors[6]} ${colors[6]}
client.focused_inactive ${colors[8]} ${colors[0]} ${colors[6]} ${colors[8]} ${colors[8]}
client.unfocused        ${colors[8]} ${colors[0]} ${colors[6]} ${colors[8]} ${colors[8]}
client.urgent           ${colors[1]} ${colors[0]} ${colors[6]} ${colors[1]} ${colors[1]}
client.placeholder      ${colors[8]} ${colors[0]} ${colors[6]} ${colors[8]} ${colors[8]}
EOL

cat > "$generated_dir/colors-polybar-config.ini" <<EOL
[colors]
background =        ${colors[0]}
background-alt =    ${colors[8]} 
foreground =        ${colors[7]}
primary =           ${colors[4]}
secondary =         ${colors[6]}
alert =             ${colors[1]}
disabled =          ${colors[8]}
border =            ${colors[8]}
EOL

papirus_color_family=$(~/.config/scripts/find-color-family.py "${colors[6]}")

rm -rf ~/.icons/Papirus ~/.icons/Papirus-Dark ~/.icons/Papirus-Light
cp -r ~/.icons/papirus-icons-pack/papirus-icon-theme-"$papirus_color_family"-folders/* ~/.icons

cat > "$generated_dir/colors-dunst.conf" <<EOL
[global]
    frame_color = "${colors[8]}"

[urgency_low]
    background = "${colors[6]}"
    foreground = "${colors[7]}"
    timeout = 10

[urgency_normal]
    background = "${colors[6]}"
    foreground = "${colors[7]}"
    timeout = 10

[urgency_critical]
    background = "${colors[1]}"
    foreground = "${colors[7]}"
    frame_color = "${colors[8]}"
    timeout = 0
EOL

mkdir -p ~/.config/dunst/dunstrc.d
cp "$generated_dir/colors-dunst.conf" ~/.config/dunst/dunstrc.d/colors.conf