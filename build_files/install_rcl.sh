#!/bin/bash

set -ouex pipefail

# fetch the latest release build download url
RCL_URL=$(curl -s "https://api.github.com/repos/ruuda/rcl/releases" |
            jq -r '[ .[] | .assets[] | select(.name | endswith("x86_64-unknown-linux-gnu")) ][0].browser_download_url')


echo "Downloading/installing rcl"
curl -fL $RCL_URL > /usr/bin/rcl
chmod a+x /usr/bin/rcl
