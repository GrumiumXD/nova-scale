#!/bin/bash

set -ouex pipefail

# fetch the latest release build download url
RCL_URL=$(curl -s "https://api.github.com/repos/ruuda/rcl/releases" |
            jq -r '
              sort_by(.created_at) | reverse | .[0]   # newest release
              | .assets[]
              | select(.name | endswith("x86_64-unknown-linux-gnu"))
              | .browser_download_url
            ')


echo "Downloading/installing rcl"
curl -fL $RCL_URL > /usr/bin/rcl
