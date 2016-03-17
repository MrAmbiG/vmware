
#start of function
Function ShootVmPg 
{
<#
.SYNOPSIS
    Remove virtual machine portgroup
.DESCRIPTION
    This will remove the virtual machine portgroup of all the hosts of a cluster/clusters.
.NOTES
    File Name      : ShootVmPg.ps1
    Author         : gajendra d ambi
    Date           : March 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#Start of Script
$cluster = Read-Host "name of the cluster[type * to include all clusters]?"
$pg      = Read-Host "Name of the portgroup?"
Get-cluster $cluster | Get-VMHost | Get-VirtualPortGroup -Name $pg | Remove-VirtualPortGroup -Confirm:$false
#End of Script
}#End of function


