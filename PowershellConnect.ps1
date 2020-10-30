#!/usr/local/bin/pwsh

$Env:JET_URL=$args[0]
$Env:PATH='.'
$UserName=$args[1]
Enter-PSSession -HostName '127.0.0.1' -UserName $UserName

