#start of function
function PgSync
{
<#
.SYNOPSIS
    Sync portgroups properties with vSwitch
.DESCRIPTION
    This will make the portgroup to sync itself with the vswitch's settings. this will make the portgroup inherit the following from the vSwitch
    LoadBalancingPolicy
    NetworkFailoverDetectionPolicy
    NotifySwitches
    FailoverOrder
.NOTES
    File Name      : PowerMgmt.ps1
    Author         : gajendra d ambi
    Date           : March 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#Start of script#
$cluster   = Read-Host "name of the cluster[type * to include all clusters]?"
$pg        = Read-Host "name of the portgroup?"
get-cluster $cluster | Get-VMHost | sort | Get-virtualswitch -Standard | Get-VirtualPortGroup -Name $pg | get-nicteamingpolicy | Set-NicTeamingPolicy -InheritLoadBalancingPolicy $true -InheritNetworkFailoverDetectionPolicy $true -InheritNotifySwitches $true -InheritFailback $true -InheritFailoverOrder $true -Confirm:$false
Write-Host "All done, Have Fun :)"
 #End of Script#
}#End of function