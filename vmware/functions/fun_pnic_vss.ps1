<#
.SYNOPSIS
    update NIC on vswitchs.
.DESCRIPTION
    this will update the NIC assigned for a vswitch
.NOTES
    File Name      : fun_pnic_vss.ps1
    Author         : gajendra d ambi
    Date           : December 2015
    recommended    : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware   
#>

#Start of script
#start of functioin
Function fun_nic_pg {
$cluster = Read-Host "name of the cluster(hint:type * to include all cluster)"
$vss     = Read-Host "name of the vswitch(hint:type * to include all vswitchs)"
$vmnic   = Read-Host "name of the vmnic to add(hint:ex:-vmnic5;only 1 at a time"
  foreach ($vmhost in (get-cluster $cluster | get-vmhost))
  {
   $nic  = get-vmhost $vmhost | get-vmhostnetworkadapter -Physical -Name $vmnic
   get-vmhost $vmhost | get-virtualswitch -Name $vss | Add-VirtualSwitchPhysicalNetworkAdapter -VMHostPhysicalNic $nic -Confirm:$false
   #get-vmhost $vmhost | Get-VirtualSwitch -Name $vss | Set-VirtualSwitch -Nic $vmnic -Confirm:$false 
  }
}
#end of function
fun_nic_pg
#end of script
