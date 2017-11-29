#start of function
function SetIpv6 
{
<#
.SYNOPSIS
    Update Ipv6
.DESCRIPTION
    This will disable/enable Ipv6 on esxi hosts of a chosen cluster.
.NOTES
    File Name      : SetIpv6.ps1
    Author         : gajendra d ambi
    Date           : March 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#Start of script#
$cluster = Read-Host "name of the cluster[type * to include all clusters]?"
Write-Host "
1. Disable IPv6
2. Enable IPv6
" -ForegroundColor Blue -BackgroundColor White
$choice = Read-Host "type between 1 & 2"

$stopWatch = [system.diagnostics.stopwatch]::startNew()
$stopWatch.Start()

If ($choice -eq 1) { get-cluster $cluster | get-vmhost | Get-VMHostNetwork | Set-VMHostNetwork -IPv6Enabled $false }
If ($choice -eq 2) { get-cluster $cluster | get-vmhost | Get-VMHostNetwork | Set-VMHostNetwork -IPv6Enabled $true }

$stopWatch.Stop()
Write-Host "Elapsed Runtime:" $stopWatch.Elapsed.Hours "Hours" $stopWatch.Elapsed.Minutes "minutes and" $stopWatch.Elapsed.Seconds "seconds." -BackgroundColor White -ForegroundColor Black
 #End of Script#
}#End of function