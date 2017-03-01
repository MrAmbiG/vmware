#start of function
Function VssFtOff 
{
<#
.SYNOPSIS
    Allow promiscous mode
.DESCRIPTION
    This will allow promiscous mode on a vswitch.
.NOTES
    File Name      : VssFtOff.ps1
    Author         : gajendra d ambi
    Date           : March 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#Start of Script
$cluster = Read-Host "name of the cluster[type * to include all clusters]?"
$vss     = Read-Host "Name of the vSwitch?"

$stopWatch = [system.diagnostics.stopwatch]::startNew()
$stopWatch.Start()

Get-cluster $cluster | Get-VMHost | Get-VirtualSwitch -Name $vss | Get-SecurityPolicy | Set-SecurityPolicy -ForgedTransmits $false -Confirm:$false

$stopWatch.Stop()
Write-Host "Elapsed Runtime:" $stopWatch.Elapsed.Hours "Hours" $stopWatch.Elapsed.Minutes "minutes and" $stopWatch.Elapsed.Seconds "seconds." -BackgroundColor White -ForegroundColor Black
 #End of Script#
}#End of function