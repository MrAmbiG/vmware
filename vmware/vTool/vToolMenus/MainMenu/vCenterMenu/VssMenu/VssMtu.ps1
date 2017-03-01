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

$stopWatch = [system.diagnostics.stopwatch]::startNew()
$stopWatch.Start()

Get-Cluster $cluster | get-vmhost | Get-Virtualswitch -Name $vss | Set-VirtualSwitch -Mtu $mtu -Confirm:$false

$stopWatch.Stop()
Write-Host "Elapsed Runtime:" $stopWatch.Elapsed.Hours "Hours" $stopWatch.Elapsed.Minutes "minutes and" $stopWatch.Elapsed.Seconds "seconds." -BackgroundColor White -ForegroundColor Black
 #End of Script#
}#End of function