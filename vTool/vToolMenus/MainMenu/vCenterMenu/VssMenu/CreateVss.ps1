
#start of function
Function CreateVss 
{
<#
.SYNOPSIS
    Create standard vSwitch.
.DESCRIPTION
    This will create a standard vSwitch of hosts of a chosen cluster.    
.NOTES
    File Name      : CreateVss.ps1
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
Get-Cluster $cluster | Get-VMHost | New-VirtualSwitch -Name $vss -Confirm:$false
#End of Script
}#End of function


