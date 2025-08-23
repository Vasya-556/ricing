# Installation

1. Installing
- Install this packages 
```bash
sudo dnf install i3 kitty polybar rofi fastfetch
```
- Clone this repository
```bash
git clone https://github.com/dylanaraps/pywal
```
- Install Eww
[follow this](https://elkowar.github.io/eww/)

2. Download media files
- [font](https://www.nerdfonts.com/font-downloads)
- [Wallpapers](https://www.wallpaperflare.com/)
- [icon theme - papirus](https://www.gnome-look.org/p/1166289)

3. Set downloaded media
- **Fonts:**
Paste font name in first line in 
```bash
~/.config/fonts/font.txt
```
and font size as a second line
- **Wallpapers:** 
Paste them to:
```bash
~/.Pictures
```
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

4. Copy folders from ricing to your config
- i3
- kitty
- polybar
- rofi
- fastfetch
- eww

# Documentations

- [i3](https://i3wm.org/docs/userguide.html)
- [kitty](https://sw.kovidgoyal.net/kitty/conf/)
- [rofi](https://davatorium.github.io/rofi/)
- [polybar](https://github.com/polybar/polybar/wiki)
- [fastfetch](https://github.com/fastfetch-cli/fastfetch)