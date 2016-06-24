
#start of function
Function VssMtu 
{
<#
.SYNOPSIS
    update Mtu on vSwitch.
.DESCRIPTION
    This will update Mtu on a chosen standard vSwitch of hosts of a chosen cluster.    
.NOTES
    File Name      : VssMtu.ps1
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
$mtu     = Read-Host "mtu?"

$TimeStart = Get-Date #start time
$TimeEnd   = Get-Date #end time
$TimeTaken = $TimeEnd - $TimeStart #total time taken
$TimeStart #starting the timer

Get-Cluster $cluster | get-vmhost | Get-Virtualswitch -Name $vss | Set-VirtualSwitch -Mtu $mtu -Confirm:$false

$TimeEnd #stopping the timer
Write-Host "Time taken - $TimeTaken" -BackgroundColor White -ForegroundColor blue #total time taken
 #End of Script#
}#End of function