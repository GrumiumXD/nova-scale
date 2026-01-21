#!/bin/bash

set -ouex pipefail

COPR_REPOS=(
    "yalter/niri"
    "ulysg/xwayland-satellite"
    "avengemedia/dms"
    "sneexy/zen-browser"
)

PACKAGES=(
    "niri"
    "dms"
    "qt6ct"
    "kf6-qqc2-desktop-style"
    "adw-gtk3-theme"
    "xwayland-satellite"
    "caja" # mate file manager
    "engrampa" # mate archiver
    "zen-browser"
    "ghostty"
    "rustup"
)

# enable copr repos
for repo in "${COPR_REPOS[@]}"; do
    dnf5 -y copr enable "$repo"
done

# install packages
dnf5 -y install ${PACKAGES[@]}

# disable copr repos
for repo in "${COPR_REPOS[@]}"; do
    dnf5 -y copr remove "$repo"
done

# install zed editor
/ctx/build_files/install_zed.sh

# install delight icon set
/ctx/build_files/install_delight_icons.sh

# Copy Files to Container
rsync -rvK /ctx/system_files/ /

# set pretty name
IMAGE_PRETTY_NAME="Nova Scale"
sed -i \
    "s|^\(PRETTY_NAME=\)\"[^\"(]*\( *(Version: [^)]*)\)\"|\1\"${IMAGE_PRETTY_NAME} \2\"|" \
    /usr/lib/os-release

# Regenerate initramfs
/ctx/build_files/initramfs.sh
