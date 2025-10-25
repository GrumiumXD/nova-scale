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
    "xwayland-satellite"
    "mate-polkit"
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

# Copy Files to Container
rsync -rvK /ctx/system_files/ /

# set pretty name
IMAGE_PRETTY_NAME="Nova Scale"
sed -i \
    "s|^\(PRETTY_NAME=\)\"[^\"(]*\( *(Version: [^)]*)\)\"|\1\"${IMAGE_PRETTY_NAME}\2\"|" \
    /usr/lib/os-release

