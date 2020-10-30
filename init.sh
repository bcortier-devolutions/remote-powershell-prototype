#!/bin/bash
set -e

eval $(./CreateAssociation.ps1)

echo "Connect URL: $ConnectUrl"

./jetsocat $ServerOptions "$AcceptUrl" "cmd:$PwshCmd"

