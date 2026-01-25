#!/bin/bash

set -ouex pipefail

ZEN_URL=https://github.com/zen-browser/desktop/releases/latest/download/zen.linux-x86_64.tar.xz
INSTALL_LOCATION=/usr/share

echo "Downloading Zen"
curl -fL $ZEN_URL > /tmp/zen.linux-x86_64.tar.xz

echo "Extracting"
mkdir -p $INSTALL_LOCATION
tar xf "/tmp/zen.linux-x86_64.tar.xz" -C $INSTALL_LOCATION

echo "Install files"
ln -sf "$INSTALL_LOCATION/zen/zen-bin" /usr/bin/zen-browser

cat << EOF > /usr/share/applications/zen-browser.desktop
#!/usr/bin/env xdg-open
[Desktop Entry]
Version=1.0
Name=Zen Browser
GenericName=Web Browser
GenericName[ca]=Navegador web
GenericName[cs]=Webový prohlížeč
GenericName[es]=Navegador web
GenericName[fa]=مرورگر اینترنتی
GenericName[fi]=WWW-selain
GenericName[fr]=Navigateur Web
GenericName[hu]=Webböngésző
GenericName[it]=Browser Web
GenericName[ja]=ウェブ・ブラウザ
GenericName[ko]=웹 브라우저
GenericName[nb]=Nettleser
GenericName[nl]=Webbrowser
GenericName[nn]=Nettlesar
GenericName[no]=Nettleser
GenericName[pl]=Przeglądarka WWW
GenericName[pt]=Navegador Web
GenericName[pt_BR]=Navegador Web
GenericName[sk]=Internetový prehliadač
GenericName[sv]=Webbläsare
Comment=Experience tranquillity while browsing the web without people tracking you!
Exec=zen-browser %u
StartupWMClass=zen
Icon=$INSTALL_LOCATION/zen/browser/chrome/icons/default/default128.png
Terminal=false
Type=Application
Categories=Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml+xml;x-scheme-handler/http;x-scheme-handler/https;application/x-xpinstall;application/pdf;application/json;
StartupNotify=true
Keywords=Internet;WWW;Browser;Web;Explorer;
EOF

