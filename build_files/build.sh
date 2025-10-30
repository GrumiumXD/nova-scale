#!/bin/bash

set -ouex pipefail

COPR_REPOS=(
    "yalter/niri"
    "ulysg/xwayland-satellite"
    "avengemedia/dms"
)

PACKAGES=(
    "niri"
    "dms"
    "qt6ct"
    "adw-gtk3-theme"
    "xwayland-satellite"
    "mate-polkit"
    "caja"
    "ghostty"
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
