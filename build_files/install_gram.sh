#!/bin/bash

set -ouex pipefail

# fetch the latest release build download url
GRAM_URL=$(curl -s "https://codeberg.org/api/v1/repos/GramEditor/gram/releases" |
            jq -r '
              sort_by(.created_at) | reverse | .[0]   # newest release
              | .assets[]
              | select(.name | startswith("gram-linux-x86_64"))
              | .browser_download_url
            ')

INSTALL_LOCATION=/usr/share/

echo "Downloading Gram"
curl -fL $GRAM_URL > /tmp/gram-linux-x86_64.tar.gz

echo "Extracting"
mkdir -p $INSTALL_LOCATION
tar xf "/tmp/gram-linux-x86_64.tar.gz" -C $INSTALL_LOCATION

echo "Setup exectuable and desktop file"
ln -sf "$INSTALL_LOCATION/gram.app/bin/gram" /usr/bin/gram
cp "$INSTALL_LOCATION/gram.app/share/applications/gram.desktop" /usr/share/applications/gram.desktop
sed -i "s|Icon=gram|Icon=$INSTALL_LOCATION/gram.app/share/icons/hicolor/512x512/apps/gram.png|g" /usr/share/applications/gram.desktop

