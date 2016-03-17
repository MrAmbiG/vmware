
#start of function
Function VssNic 
{
<#
.SYNOPSIS
    update Nics on vSwitch.
.DESCRIPTION
    This will update Nics on a chosen standard vSwitch of hosts of a chosen cluster.    
.NOTES
    File Name      : VssNic.ps1
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
$nic     = Read-Host "number of ports?"
 foreach ($vmhost in (get-cluster $cluster | get-vmhost))
 {
  $vmnic = Get-VMhost $vmhost | Get-VMHostNetworkAdapter -Physical -Name $nic
  Get-VirtualSwitch $vss | Add-VirtualSwitchPhysicalNetworkAdapter -VMHostPhysicalNic $vmnic
 }
#End of Script
}#End of function


