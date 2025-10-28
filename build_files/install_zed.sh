#!/bin/bash

set -ouex pipefail

ZED_URL=https://zed.dev/api/releases/stable/latest/zed-linux-x86_64.tar.gz
INSTALL_LOCATION=/usr/share/zed

echo "Downloading Zed"
curl -fL $ZED_URL > /tmp/zed-linux-x86_64.tar.gz

echo "Extracting"
mkdir -p $INSTALL_LOCATION
tar xf "/tmp/zed-linux-x86_64.tar.gz" -C $INSTALL_LOCATION

echo "Install files"
ln -sf "$INSTALL_LOCATION/zed.app/bin/zed" /usr/bin/zedit
cp "$INSTALL_LOCATION/zed.app/share/applications/zed.desktop" /usr/share/applications/dev.zed.Zed.desktop
sed -i "s|Icon=zed|Icon=$INSTALL_LOCATION/zed.app/share/icons/hicolor/512x512/apps/zed.png|g" /usr/share/applications/dev.zed.Zed.desktop
sed -i "s|Exec=zed|Exec=$INSTALL_LOCATION/zed.app/libexec/zed-editor|g" /usr/share/applications/dev.zed.Zed.desktop

