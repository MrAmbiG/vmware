 
#start of function
Function Setlbsi 
{
<#
.SYNOPSIS
    Set LoadBalanceSrcId on VDS.
.DESCRIPTION
    This will set the loadbalancing on the vds as LoadBalanceSrcId.
.NOTES
    File Name      : Setlbsi.ps1
    Author         : gajendra d ambi
    Date           : March 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#Start of Script
$dvs = Read-Host "name of the dvSwitch?"
Get-VDswitch -Name $dvs | Set-NicTeamingPolicy -LoadBalancingPolicy LoadBalanceSrcId -Confirm:$false
#End of Script
}#End of function
