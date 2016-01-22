<#
.SYNOPSIS
    update Nic on vswitchs.
.DESCRIPTION
    this will update the Nics assigned for a vswitch
.NOTES
    File Name      : fun_Nic_vss.ps1
    Author         : gajendra d ambi
    Date           : December 2015
    recommended    : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware 
    #resources
    https://www.vmware.com/support/developer/PowerCLI/PowerCLI60R3/html/Add-VirtualSwitchPhysicalNetworkAdapter.html 
    http://pubs.vmware.com/vsphere-55/index.jsp?topic=%2Fcom.vmware.powercli.cmdletref.doc%2FSet-VirtualSwitch.html
#>

#Start of script

Function fun_Nic_vss {
$cluster = Read-Host "name of the cluster(hint:type * to include all cluster)"
$vss     = Read-Host "name of the vswitch"
$Nic     = Read-Host "vmnic?(ex:vmnic1 or vmnic3 enter only 1 value at a time)"
  foreach ($vmhost in (get-cluster $cluster | get-vmhost))
  {
   $vmnic = Get-VMhost $vmhost | Get-VMHostNetworkAdapter -Physical -Name $Nic
   Get-VirtualSwitch $vss | Add-VirtualSwitchPhysicalNetworkAdapter -VMHostPhysicalNic $vmnic 
  }
}
fun_Nic_vss
#End of script
