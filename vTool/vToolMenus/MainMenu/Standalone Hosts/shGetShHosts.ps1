#start of function
function shGetShHosts 
{
<#
.SYNOPSIS
    Connect to standalone hosts
.DESCRIPTION
    This will get the 1st host's ip address and increment it to a number specified by the user and connect to all of them.
.NOTES
    File Name      : shNewVss.ps1
    Author         : gajendra d ambi
    Date           : April 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#Start of script#

$1sthost  = Read-Host "1st host's ip address?"
$max      = Read-Host "total number of esxi hosts that you want to configure?"
$user     = Read-Host "ESXi username?"
$pass     = Read-Host "ESXi password?"

#generate the range of ip addresses of hosts
$fixed = $1sthost.Split('.')[0..2]
$last = [int]($1sthost.Split('.')[3])
$maxhosts = $max - 1
$hosts = 
$last..($last + $maxhosts) | %{
    [string]::Join('.',$fixed) + "." + $_
}

#connect to all hosts
connect-viserver $hosts -User $user -Password $pass
}