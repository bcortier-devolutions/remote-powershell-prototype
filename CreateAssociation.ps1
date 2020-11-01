#!/usr/local/bin/pwsh

$JetRelayUrl = 'https://jet-relay.ngrok.io'
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

# output some variables for bash eval

$AcceptUrl = "${CandidateUrl}jet/accept/$AssociationId/$CandidateId"
$ConnectUrl = "${CandidateUrl}jet/connect/$AssociationId/$CandidateId"
$TestUrl = "${CandidateUrl}jet/test/$AssociationId/$CandidateId"
Write-Host "AcceptUrl='$AcceptUrl'"
Write-Host "ConnectUrl='$ConnectUrl'"
Write-Host "TestUrl='$TestUrl'"

