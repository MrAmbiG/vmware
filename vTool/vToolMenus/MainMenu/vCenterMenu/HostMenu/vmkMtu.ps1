#start of function
Function vmkMtu 
{
<#
.SYNOPSIS
    update Mtu on vmkernel.
.DESCRIPTION
    This will update Mtu on a chosen vmkernel of hosts of a chosen cluster.    
.NOTES
    File Name      : vmkMtu.ps1
    Author         : gajendra d ambi
    Date           : March 2017
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#Start of Script
$cluster = Read-Host "name of the cluster[type * to include all clusters]?"
$vmk     = Read-Host "name of the vmk(ex:vmk1)?"
$mtu     = Read-Host "mtu?"

$stopWatch = [system.diagnostics.stopwatch]::startNew()
$stopWatch.Start()

Get-Cluster $cluster | get-vmhost | Get-VMHostNetworkAdapter | Where { $_.GetType().Name -eq "HostVMKernelVirtualNicImpl" } | where DeviceName -Match $vmk | Foreach { $_ | Set-VMHostNetworkAdapter -Mtu $mtu -Confirm:$false }

$stopWatch.Stop()
Write-Host "Elapsed Runtime:" $stopWatch.Elapsed.Hours "Hours" $stopWatch.Elapsed.Minutes "minutes and" $stopWatch.Elapsed.Seconds "seconds." -BackgroundColor White -ForegroundColor Black
 #End of Script#
}#End of function