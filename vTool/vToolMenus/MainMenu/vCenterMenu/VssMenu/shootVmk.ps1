#start of function shootVmk
function shootVmk 
{
<#
.SYNOPSIS
    delete vmkernel
.DESCRIPTION
    This will remove the vmkernel from hosts. you can do this for standard or virtual portgroup and then delete the portgroup.
.NOTES
    File Name      : shootVmk.ps1
    Author         : gajendra d ambi
    Date           : march 2017
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#Start of script#
$cluster = Read-Host "Name of the Cluster?"
$vmk = Read-Host "name of the vmk? (ex:vmk4)"
$vmhosts = get-cluster $cluster | get-vmhost

foreach ($vmhost in $vmhosts)
{
$vmk = Get-VMHostNetworkAdapter -VMHost $vmhost | where DeviceName -eq $vmk
$vmk
Remove-VMHostNetworkAdapter -Nic $vmk -confirm:$false
}
} #end of function shootVmk