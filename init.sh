#!/bin/bash
set -e

eval $(./CreateAssociation.ps1)

echo "Connect URL: $ConnectUrl"
printf "$ConnectUrl" | xclip -selection clipboard

./jetsocat --no-close --binary "$AcceptUrl" "cmd:/usr/local/bin/pwsh -sshs -NoLogo -NoProfile"

