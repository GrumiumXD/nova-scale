#!/bin/bash

set -ouex pipefail

GIT_URL=https://github.com/SethStormR/Delight-2.git

echo "Cloning repo"
git clone $GIT_URL /tmp/delight2

echo "Extracting"
tar xf "/tmp/delight2/Delight 2.tgz" -C /usr/share/icons
