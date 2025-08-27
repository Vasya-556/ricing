#!/bin/bash

font_file="$HOME/.config/fonts/font.txt"
generated_dir="$HOME/.config/generated"
mkdir -p "$generated_dir"

mapfile -t font_data < "$font_file"
polybar_font_size=$(( font_data[1] - 2 ))
dunst_font_size=$(( font_data[1] - 4))

cat > "$generated_dir/font-kitty-config.conf" <<EOL
font_family     ${font_data[0]}
font_size       ${font_data[1]}
EOL

cat > "$generated_dir/font-rofi-config.rasi" <<EOL
configuration {
    font: "${font_data[0]} ${font_data[1]}";
}
EOL

cat > "$generated_dir/font-polybar-config.ini" << EOL
font-0 = "${font_data[0]}:size=${polybar_font_size};2"
EOL

cat > "$HOME/.config/gtk-3.0/gtk.css" << EOL
* {
    font-family: "${font_data[0]}";
}
EOL

cat > "$HOME/.config/gtk-4.0/gtk.css" << EOL
* {
    font-family: "${font_data[0]}";
}
EOL

cat > "$generated_dir/font-dunst.conf" <<EOL
[global]
    font = ${font_data[0]} ${dunst_font_size}
EOL

mkdir -p ~/.config/dunst/dunstrc.d
cp "$generated_dir/font-dunst.conf" ~/.config/dunst/dunstrc.d/font.conf