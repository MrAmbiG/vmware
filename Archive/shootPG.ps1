<#
.SYNOPSIS
   This will remove the  portgroup
.DESCRIPTION
   This will first remove the vmkernel adapter on the target portgroup, then remove the portgroup.
.NOTES
    File Name      : shootPG.ps1
    Author         : gajendra d ambi
    Date           : December 2015 
    Prerequisite   : PowerShell V3, powercli 5+ over Vista and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#start of script
#variables
$cluster   = "*"
Write-Host Name of the portgroup to remove?
$portgroup = Read-host ""

#Connect to vcenter server or a single host or hosts
Connect-VIServer
$vmhosts   = get-cluster "*" | Get-VMHost | sort
foreach ($vmhost in $vmhosts)
{
$pgs       = get-vmhost $vmhost | get-virtualportgroup | select name
if ($pgs -match "$portgroup")
 {
  $vmk = Get-VMHostNetworkAdapter -VMHost $vmhost | where PortgroupName -eq $portgroup
  Write-Host found $portgroup with vmkernel $vmk on $vmhost -ForegroundColor yellow
  Write-Host removing vmkernel $vmk on $vmhost -ForegroundColor Green

  #removing vmkernel
  Write-Host removing the vmkernel $vmk from portgrop $portgroup on the host $vmhost -ForegroundColor Green
  Remove-VMHostNetworkAdapter -Nic $vmk -confirm:$false

  #removing portgroup
  Write-Host removing the portgrop $portgroup on the host $vmhost -ForegroundColor Blue
  get-virtualportgroup -Name $portgroup | Remove-VirtualPortGroup -Confirm:$false
 }
}
#end of script
