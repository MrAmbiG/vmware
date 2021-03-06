<#
.SYNOPSIS
    update MTU on vswitchs.
.DESCRIPTION
    this will update the MTU assigned for a vswitch
.NOTES
    File Name      : fun_mtu_vss.ps1
    Author         : gajendra d ambi
    Date           : December 2015
    recommended    : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware   
#>

#Start of script

Function fun_mtu_vss {
$cluster = Read-Host "name of the cluster(hint:type * to include all cluster)"
$vss     = Read-Host "name of the vswitch(hint:type * to include all vswitchs)"
$mtu     = Read-Host "mtu?"
  foreach ($vmhost in (get-cluster $cluster | get-vmhost))
  {
   get-vmhost $vmhost | get-virtualswitch -Name $vss | Set-VirtualSwitch -Mtu $mtu -Confirm:$false
  }
}
fun_mtu_vss
#End of script
