
#start of function
Function VssPorts 
{
<#
.SYNOPSIS
    update portgroups on vSwitch.
.DESCRIPTION
    This will update portgroups on a chosen standard vSwitch of hosts of a chosen cluster.    
.NOTES
    File Name      : VssPorts.ps1
    Author         : gajendra d ambi
    Date           : March 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#Start of Script
$cluster = Read-Host "name of the cluster[type * to include all clusters]?"
$vss     = Read-Host "name of the vSphere standard Switch?"
$ports   = Read-Host "number of ports?"

$TimeStart = Get-Date #start time
$TimeEnd   = Get-Date #end time
$TimeTaken = $TimeEnd - $TimeStart #total time taken
$TimeStart #starting the timer

Get-Cluster $cluster | Get-VMHost | Get-VirtualSwitch -Name $vss | Set-VirtualSwitch -NumPorts $ports -Confirm:$false

$TimeEnd #stopping the timer
Write-Host "Time taken - $TimeTaken" -BackgroundColor White -ForegroundColor blue #total time taken
 #End of Script#
}#End of function