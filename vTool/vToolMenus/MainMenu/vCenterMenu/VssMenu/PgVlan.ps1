
#start of function
Function PgVlan 
{
<#
.SYNOPSIS
    update virtual machine portgroup's Vlan on vSwitch.
.DESCRIPTION
    This will update virtual machine portgroup's Vlan on a chosen portgroup of hosts of a chosen cluster.    
.NOTES
    File Name      : PgVlan.ps1
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
$vlan    = Read-Host "New Vlan?"
Get-cluster $cluster | Get-VMHost | Get-VirtualPortGroup -Name $pg | Set-VirtualPortGroup -VLanId $vlan -Confirm:$false
#End of Script
}#End of function


