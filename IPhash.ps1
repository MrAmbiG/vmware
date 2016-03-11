<#
.SYNOPSIS
   This will set the ip hashing on the mentioned vswtchs.
.DESCRIPTION
   You have to mention the name of the cluster and vswitchs for it to change the load balancing to ip hash.
.NOTES
    File Name      : IPhash.ps1
    Author         : gajendra d ambi
    Date           : October 2015 
    Prerequisite   : PowerShell V3, powercli 5+ over Vista and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
    
#>

#Start of script
#Variables
$vc=read-host "target vcenter address?"
$user=read-host "username of the vcenter?"
$pass=read-host "password of the vcenter?"
$cluster=read-host "name of the cluster?"
$vss1=read-host "name of the 1st vswitch?"
$vss2=read-host "name of the 2nd vswitch?"

#connect to the vcenter
connect-viserver $vc -user root -Password VMwar3!!

#set nicteamingpolicy for the vswitchs to ip hash
get-cluster $cluster | get-vmhost | get-virtualswitch -Name $vss1,$vss2 | Get-NicTeamingPolicy | Set-NicTeamingPolicy -LoadBalancingPolicy LoadBalanceIP

#get nicteamingpolicy for the vswitchs
get-cluster $cluster | get-vmhost | get-virtualswitch -Name $vss1,$vss2 | Get-NicTeamingPolicy | select VirtualSwitch, LoadBalancingPolicy

#set nicteamingpolicy for the portgroups to ip hash
get-cluster $cluster | get-vmhost | get-virtualswitch -Name $vss1,$vss2 | get-virtualportgroup -Name * | Get-NicTeamingPolicy | Set-NicTeamingPolicy -LoadBalancingPolicy LoadBalanceIP

#get nicteamingpolicy for the portgroups
get-cluster $cluster | get-vmhost | get-virtualswitch -Name $vss1,$vss2 | get-virtualportgroup -Name * | Get-NicTeamingPolicy | select VirtualPortGroup, LoadBalancingPolicy

#End of script
