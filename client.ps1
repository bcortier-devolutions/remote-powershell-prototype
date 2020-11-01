#!/usr/bin/env pwsh

$Env:PATH = "$(Get-Location):${Env:PATH}"
Enter-PSSession -HostName 'localhost' -UserName 'wayk'

