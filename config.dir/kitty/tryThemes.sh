function tryTheme {
    read -r -p "Try $1? [Y/n] " YESNO
    if [ "$YESNO" = "n" ]; then
        printf "Skipping $1...\n"
    else
        printf "Applying $1...\n"
        kitty +kitten themes --config-file-name themes.conf $@
    fi
}

tryTheme "Arthur"
tryTheme "Broadcast"
tryTheme "Catppuccin-Mocha"
tryTheme "GitHub Dark Colorblind"
tryTheme "Japanesque"
tryTheme "Jellybeans"
tryTheme "kanagawabones"
tryTheme "Kaolin Dark"
tryTheme "Leaf Dark"
tryTheme "Mayukai"
tryTheme "Nightfly"
tryTheme "Nightfox"
tryTheme "One Half Dark"
tryTheme "Pnevma"
tryTheme "Rosé Pine"
tryTheme "Rosé Pine Moon"
tryTheme "Smyck"
tryTheme "Sourcerer"
tryTheme "Space Gray Eighties"
tryTheme "Substrata"
tryTheme "Teerb"
tryTheme "Tokyo Night"
tryTheme "Tokyo Night Moon"
tryTheme "Tomorrow Night"
tryTheme "Tomorrow Night Bright"
tryTheme "Wombat"
tryTheme "YsDark"
tryTheme "zenbones_dark"
tryTheme "zenwritten_dark"
