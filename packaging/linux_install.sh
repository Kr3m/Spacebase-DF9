#!/usr/bin/env bash

VERSION=1.08

# Accept STEAM_COMMON and SBDF9_SAVES as env variables
: ${STEAM_COMMON:=~/.steam/steam/SteamApps/common/}
: ${SBDF9_SAVES:=~/.local/share/doublefine/spacebasedf9/Saves/}

if [ "$1" = "restore" ]; then
    if [ ! -d "${STEAM_COMMON}/SpacebaseDF9.v1" ]; then
	echo "Missing original version of game to be restored"
	echo "Try manually re-installing through Steam"
    else
	rm -rf "${STEAM_COMMON}/SpacebaseDF9"
	mv "${STEAM_COMMON}/SpacebaseDF9.v1" "${STEAM_COMMON}/SpacebaseDF9"
    fi
    exit
fi

# If running from the packaging directory, hop up to parent dir
if [ $(dirname $0) = "." ]; then
    cd ..
fi

## Backup if needed
if [ ! -e ${STEAM_COMMON}/SpacebaseDF9.v1 ]; then
    echo "Backing up original SpacebaseDF9 code and game save"
    rsync -avz "${STEAM_COMMON}/SpacebaseDF9/" "${STEAM_COMMON}/SpacebaseDF9.v1"
fi
if [ ! -e "${SBDF9_SAVES}/Archives/SpacebaseDF9AutoSave-v1.sav" ]; then
    mkdir -p "${SBDF9_SAVES}/Archives"
    rsync -avz "${SBDF9_SAVES}/SpacebaseDF9AutoSave.sav" "${SBDF9_SAVES}/Archives/SpacebaseDF9AutoSave-v1.sav"
fi

rsync -avz README "${STEAM_COMMON}/SpacebaseDF9/"

rsync -avz Data/* "${STEAM_COMMON}/SpacebaseDF9/Data/"

# Treat Win directory as authoritative for graphics
rsync -avz Win/* "${STEAM_COMMON}/SpacebaseDF9/Linux/"

rsync -avz Texture/* "${STEAM_COMMON}/SpacebaseDF9/Texture/"

