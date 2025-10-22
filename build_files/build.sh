#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

dnf5 -y copr enable yalter/niri
dnf5 -y copr enable ulysg/xwayland-satellite 

dnf5 -y config-manager setopt "terra".enabled=true

# this installs a package from fedora repos
dnf5 install -y niri ghostty xwayland-satellite

dnf5 -y config-manager setopt "terra".enabled=false

dnf5 -y copr disable yalter/niri
dnf5 -y copr disable ulysg/xwayland-satellite 

IMAGE_PRETTY_NAME="Nova Scale"
sed -i "s|^PRETTY_NAME=.*|PRETTY_NAME=\"${IMAGE_PRETTY_NAME} (Version: ${VERSION})\"|" /usr/lib/os-release

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

# systemctl enable podman.socket
