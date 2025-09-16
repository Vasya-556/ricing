# Configuration

1. Installing
- Install this packages 
```bash
sudo dnf install i3 kitty polybar rofi fastfetch dunst mpd cava mpv vokoscreenNG
```

2. Install this repositories
- [install pywal](https://github.com/dylanaraps/pywal)
- [Install betterlockscreen](https://github.com/betterlockscreen/betterlockscreen)
*Optional*
- [install pastel](https://github.com/sharkdp/pastel)
- [install durdraw](https://github.com/cmang/durdraw/)
- [Install rmpc](https://mierak.github.io/rmpc/)


3. Download media files
- [font](https://www.nerdfonts.com/font-downloads)
- [icon theme - papirus](https://www.gnome-look.org/p/1166289)

4. Set downloaded media
- **Fonts:**
Paste font name in first line in 
```bash
~/.config/fonts/font.txt
```
and font size as a second line

- **icon theme**
Extract folder and paste it into
```bash
~/.icons
```
set *settings.ini* in gtk-3.0 and gtk-4.0 to match icon theme
```ini
[Settings]
gtk-icon-theme-name = Papirus
```

1. Copy all folders from ricing to ~/.config

2. Run this
```bash
ln -s ~/.config/scripts/main.sh ~/.local/bin/wp
```

1. Set betterlockscreen
```bash
cd ~/.config/betterlockscreen
betterlockscreen -u 1.jpg
```

1. Change wallpapers
```bash
wp path/image
```

# Documentations

- [i3](https://i3wm.org/docs/userguide.html)
- [kitty](https://sw.kovidgoyal.net/kitty/conf/)
- [rofi](https://davatorium.github.io/rofi/)
- [polybar](https://github.com/polybar/polybar/wiki)
- [fastfetch](https://github.com/fastfetch-cli/fastfetch)
- [dunst](https://dunst-project.org/documentation/)
- [mpd](https://mpd.readthedocs.io/en/latest/)
- [rmpc](https://mierak.github.io/rmpc/)
- [cava](https://github.com/karlstav/cava)
- [mpv](https://mpv.io/)
- [betterlockscreen](https://github.com/betterlockscreen/betterlockscreen)
- [durdraw](https://github.com/cmang/durdraw/)
- [pastel](https://github.com/sharkdp/pastel)