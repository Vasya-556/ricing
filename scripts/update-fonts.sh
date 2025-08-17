#!/bin/bash

font_file="$HOME/.config/fonts/font.txt"
generated_dir="$HOME/.config/generated"
mkdir -p "$generated_dir"

mapfile -t font_data < "$font_file"

cat > "$generated_dir/kitty-font.conf" <<EOL
font_family     ${font_data[0]}
font_size       ${font_data[1]}
EOL

cat > "$generated_dir/rofi-font.rasi" <<EOL
configuration {
    font: "${font_data[0]} ${font_data[1]}";
}
EOL