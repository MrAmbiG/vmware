
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
$newnic  = Read-Host "Name of the Nic (ex:vmnic5)?"
foreach ($vmhost in (get-cluster $cluster | get-vmhost | sort)) {
 $vmnic = get-vmhost $vmhost | Get-VMHostNetworkAdapter -Physical -Name $newnic
 get-vmhost $vmhost | get-virtualswitch -Name $vss | Add-VirtualSwitchPhysicalNetworkAdapter -VMHostPhysicalNic $vmnic -confirm:$false
 }
#End of Script
}#End of function