#!/usr/bin/env pwsh

Remove-Item $(Join-Path $PSScriptRoot 'ssh') -Force -ErrorAction SilentlyContinue
Remove-Item $(Join-Path $PSScriptRoot 'server.sh') -Force -ErrorAction SilentlyContinue

$ConnectUrl = "ws://127.0.0.1:5001"
$AcceptUrl = "127.0.0.1:5001"

$ClientCommand = "jetsocat connect $ConnectUrl"
Set-Content -Path $(Join-Path $PSScriptRoot 'ssh') -Value "#!/bin/sh`n$ClientCommand`n" -Force

$ServerCommand = "jetsocat listen $AcceptUrl --cmd 'pwsh -sshs -NoLogo -NoProfile'"
Set-Content -Path $(Join-Path $PSScriptRoot 'server.sh') -Value "#!/bin/sh`n$ServerCommand`n" -Force

chmod +x ssh
chmod +x server.sh
