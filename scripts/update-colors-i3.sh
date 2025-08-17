#!/bin/bash

colors_file="$HOME/.cache/wal/colors"
generated_dir="$HOME/.config/generated"
mkdir -p "$generated_dir"

mapfile -t colors < "$colors_file"

cat > "$generated_dir/colors-i3.conf" <<EOL
client.focused          ${colors[6]} ${colors[0]} ${colors[6]} ${colors[6]} ${colors[6]}
client.focused_inactive ${colors[8]} ${colors[0]} ${colors[6]} ${colors[8]} ${colors[8]}
client.unfocused        ${colors[8]} ${colors[0]} ${colors[6]} ${colors[8]} ${colors[8]}
client.urgent           ${colors[1]} ${colors[0]} ${colors[6]} ${colors[1]} ${colors[1]}
client.placeholder      ${colors[8]} ${colors[0]} ${colors[6]} ${colors[8]} ${colors[8]}
EOL