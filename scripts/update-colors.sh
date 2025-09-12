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

cat > "$generated_dir/pywal.ron" <<EOL
#![enable(implicit_some)]
#![enable(unwrap_newtypes)]
#![enable(unwrap_variant_newtypes)]
(
    default_album_art_path: None,
    show_song_table_header: true,
    draw_borders: true,
    format_tag_separator: " | ",
    browser_column_widths: [20, 38, 42],
    background_color: None,
    text_color: None,
    header_background_color: None,
    modal_background_color: None,
    modal_backdrop: false,
    preview_label_style: (fg: "${colors[3]}"),
    preview_metadata_group_style: (fg: "${colors[3]}", modifiers: "Bold"),
    tab_bar: (
        enabled: true,
        active_style: (fg: "${colors[0]}", bg: "${colors[4]}", modifiers: "Bold"),
        inactive_style: (),
    ),
    highlighted_item_style: (fg: "${colors[4]}", modifiers: "Bold"),
    current_item_style: (fg: "${colors[0]}", bg: "${colors[4]}", modifiers: "Bold"),
    borders_style: (fg: "${colors[4]}"),
    highlight_border_style: (fg: "${colors[4]}"),
    symbols: (
        song: "S",
        dir: "D",
        playlist: "P",
        marker: "->",
        ellipsis: "...",
        song_style: None,
        dir_style: None,
        playlist_style: None,
    ),
    level_styles: (
        info: (fg: "${colors[4]}", bg: "${colors[0]}"),
        warn: (fg: "${colors[3]}", bg: "${colors[0]}"),
        error: (fg: "${colors[1]}", bg: "${colors[0]}"),
        debug: (fg: "${colors[2]}", bg: "${colors[0]}"),
        trace: (fg: "${colors[5]}", bg: "${colors[0]}"),
    ),
    progress_bar: (
        symbols: ["[", "-", ">", " ", "]"],
        track_style: (fg: "${colors[0]}"),
        elapsed_style: (fg: "${colors[4]}"),
        thumb_style: (fg: "${colors[4]}", bg: "${colors[0]}"),
    ),
    scrollbar: (
        symbols: ["│", "█", "▲", "▼"],
        track_style: (),
        ends_style: (),
        thumb_style: (fg: "${colors[4]}"),
    ),
    song_table_format: [
        (
            prop: (kind: Property(Artist),
                default: (kind: Text("Unknown"))
            ),
            width: "20%",
        ),
        (
            prop: (kind: Property(Title),
                default: (kind: Text("Unknown"))
            ),
            width: "35%",
        ),
        (
            prop: (kind: Property(Album), style: (fg: "${colors[7]}"),
                default: (kind: Text("Unknown Album"), style: (fg: "${colors[7]}"))
            ),
            width: "30%",
        ),
        (
            prop: (kind: Property(Duration),
                default: (kind: Text("-"))
            ),
            width: "15%",
            alignment: Right,
        ),
    ],
    components: {},
    layout: Split(
        direction: Vertical,
        panes: [
            (
                pane: Pane(Header),
                size: "2",
            ),
            (
                pane: Pane(Tabs),
                size: "3",
            ),
            (
                pane: Pane(TabContent),
                size: "100%",
            ),
            (
                pane: Pane(ProgressBar),
                size: "1",
            ),
        ],
    ),
    header: (
        rows: [
            (
                left: [
                    (kind: Text("["), style: (fg: "${colors[3]}", modifiers: "Bold")),
                    (kind: Property(Status(StateV2(playing_label: "Playing", paused_label: "Paused", stopped_label: "Stopped"))), style: (fg: "${colors[3]}", modifiers: "Bold")),
                    (kind: Text("]"), style: (fg: "${colors[3]}", modifiers: "Bold"))
                ],
                center: [
                    (kind: Property(Song(Title)), style: (modifiers: "Bold"),
                        default: (kind: Text("No Song"), style: (modifiers: "Bold"))
                    )
                ],
                right: [
                    (kind: Property(Widget(ScanStatus)), style: (fg: "${colors[4]}")),
                    (kind: Property(Widget(Volume)), style: (fg: "${colors[4]}"))
                ]
            ),
            (
                left: [
                    (kind: Property(Status(Elapsed))),
                    (kind: Text(" / ")),
                    (kind: Property(Status(Duration))),
                    (kind: Text(" (")),
                    (kind: Property(Status(Bitrate))),
                    (kind: Text(" kbps)"))
                ],
                center: [
                    (kind: Property(Song(Artist)), style: (fg: "${colors[3]}", modifiers: "Bold"),
                        default: (kind: Text("Unknown"), style: (fg: "${colors[3]}", modifiers: "Bold"))
                    ),
                    (kind: Text(" - ")),
                    (kind: Property(Song(Album)),
                        default: (kind: Text("Unknown Album"))
                    )
                ],
                right: [
                    (
                        kind: Property(Widget(States(
                            active_style: (fg: "${colors[7]}", modifiers: "Bold"),
                            separator_style: (fg: "${colors[7]}")))
                        ),
                        style: (fg: "${colors[8]}")
                    ),
                ]
            ),
        ],
    ),
    browser_song_format: [
        (
            kind: Group([
                (kind: Property(Track)),
                (kind: Text(" ")),
            ])
        ),
        (
            kind: Group([
                (kind: Property(Artist)),
                (kind: Text(" - ")),
                (kind: Property(Title)),
            ]),
            default: (kind: Property(Filename))
        ),
    ],
    lyrics: (
        timestamp: false
    )
)
EOL

mkdir -p ~/.config/rmpc/themes
cp "$generated_dir/pywal.ron" ~/.config/rmpc/themes/pywal.ron