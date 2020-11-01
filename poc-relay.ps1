#!/usr/bin/env pwsh

$JetRelayUrl = 'https://api.jet-relay.xyz'
$AssociationId = New-Guid
$TimeoutSec = 5

$Headers = @{
	"Content-Type" = "application/json";
}

$Response = Invoke-WebRequest -UseBasicParsing -Method 'POST' -Headers $Headers `
	-Uri "$JetRelayUrl/jet/association/$AssociationId/candidates" `
	-TimeoutSec $TimeoutSec

$Candidates = $($Response.Content | ConvertFrom-Json).candidates

$WssCandidate = $Candidates | Where-Object { $_.url -Like 'wss://*' } | Select-Object -First 1
$CandidateId = $WssCandidate.id
$CandidateUrl = $WssCandidate.url

$AcceptUrl = "${CandidateUrl}jet/accept/$AssociationId/$CandidateId"
$ConnectUrl = "${CandidateUrl}jet/connect/$AssociationId/$CandidateId"
$TestUrl = "${CandidateUrl}jet/test/$AssociationId/$CandidateId"
Write-Host "$AcceptUrl"
Write-Host "$ConnectUrl"

Remove-Item $(Join-Path $PSScriptRoot 'ssh') -Force -ErrorAction SilentlyContinue
Remove-Item $(Join-Path $PSScriptRoot 'server.sh') -Force -ErrorAction SilentlyContinue

$ClientCommand = "jetsocat connect $ConnectUrl"
Set-Content -Path $(Join-Path $PSScriptRoot 'ssh') -Value "#!/bin/sh`n$ClientCommand`n" -Force
chmod +x ssh

$ServerCommand = "jetsocat accept $AcceptUrl"
Set-Content -Path $(Join-Path $PSScriptRoot 'server.sh') -Value "#!/bin/sh`n$ServerCommand`n" -Force
chmod +x server.sh

