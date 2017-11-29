# start of function
function checkIpConnectivity 
{
<#
.SYNOPSIS
    test connection of an ip range
.DESCRIPTION
    Takes the starting and ending ip from the user as input then
    1. prints the list of IPs which are not reachable and their count
    2. prints the list of IPs which are reachable and their count
    repeats the process 1 and 2 till the unreachable ip count is 0
.NOTES
    File Name      : checkIpConnectivity.ps1
    Author         : gajendra d ambi
    Date           : June 2017
    Prerequisite   : PowerShell v4+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/MrAmbiG/
#>
#Start of Script

$startIp = Read-Host "Starting IP?"
$endIp = Read-Host "Ending IP?"

$a     = $startIp.Split('.')[0..2]   
#first 3 octets of the ip address
$b     = [string]::Join(".",$a)
#last octet of the ip address
$c     = $startIp.Split('.')[3]
$c     = [int]$c

$ipArray = @()
do {
$ip = "$b.$(($c++))"
$ipArray += $ip
} until ($ip -eq $endIp)

do {
$reachable = @()
$notReachable = @()
Write-Host "

"
foreach ($ip in $ipArray)
    {
    Write-Host "

    "
    write-host checking $ip -foregroundcolor yellow
    $check = Test-Connection -ComputerName $ip -ErrorAction SilentlyContinue
    if ($check) { $reachable += $ip} else { $notReachable += $ip }
    }
    Write-Host Not Reachable -ForegroundColor Red
    Write-Host ------------- -ForegroundColor White
    foreach ($ip in $notReachable) { Write-Host $ip -ForegroundColor Red }
    write-host Total Count: $notReachable.count
    Write-Host "

    "
    Write-Host Reachable -ForegroundColor Green
    Write-Host --------- -ForegroundColor White
    foreach ($ip in $reachable) { Write-Host $ip -ForegroundColor Green }
    write-host Total Count: $reachable.count
    } until (!$notReachable)
}# end of function