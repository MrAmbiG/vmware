
#start of function
Function VssMcOff
{
<#
.SYNOPSIS
    Allow promiscous mode
.DESCRIPTION
    This will allow promiscous mode on a vswitch.
.NOTES
    File Name      : VssMcOff.ps1
    Author         : gajendra d ambi
    Date           : March 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#Start of Script
$cluster = Read-Host "name of the cluster[type * to include all clusters]?"
$vss     = Read-Host "Name of the vSwitch?"
Get-cluster $cluster | Get-VMHost | Get-VirtualSwitch -Name $vss | Get-SecurityPolicy | Set-SecurityPolicy -MacChanges $false -Confirm:$false
#End of Script
}#End of function


