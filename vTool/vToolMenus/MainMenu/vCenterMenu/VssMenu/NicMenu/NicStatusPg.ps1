#Start of function
function NicStatusPg
{
<#
.SYNOPSIS
    Change nic teaming of nics.
.DESCRIPTION
    This will change the nic status on portgroups
.NOTES
    File Name      : NicStatusPg.ps1
    Author         : gajendra d ambi
    Date           : July 2016
    Prerequisite   : PowerShell v4+, powercli 6.3+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/MrAmbiG/vmware
#>
#Start of Script
$cluster = Read-Host "cluster[type * to include all clusters]?"
$pg      = Read-Host "standard portgroup?"
$nic     = Read-Host "vmnic (ex:vmnic5)?"

Write-host "
1 . MakeNicActive
2 . MakeNicStandby
3 . MakeNicUnused
" -BackgroundColor white -ForegroundColor black
Write-Host choose from 1 to 3 from above -BackgroundColor Yellow -ForegroundColor Black
$option = Read-Host " "

$stopWatch = [system.diagnostics.stopwatch]::startNew()
$stopWatch.Start()

$vmhosts = get-cluster $cluster | get-vmhost | sort

$vmhosts = get-cluster $cluster | get-vmhost | sort
foreach ($vmhost in $vmhosts)
{
$vmnic = get-vmhost $vmhost | Get-VMHostNetworkAdapter -Physical -Name $nic
    if ($option -eq 1) 
    {#MakeNicActive
    get-vmhost $vmhost | get-virtualportgroup -Name $pg | Get-NicTeamingPolicy | Set-NicTeamingPolicy -MakeNicActive $vmnic -Confirm:$false
    }
    if ($option -eq 2)
    {#MakeNicStandby
    get-vmhost $vmhost | get-virtualportgroup -Name $pg | Get-NicTeamingPolicy | Set-NicTeamingPolicy -MakeNicStandby $vmnic -Confirm:$false
    }
    if ($option -eq 3)
    {#MakeNicUnused
    get-vmhost $vmhost | get-virtualportgroup -Name $pg | Get-NicTeamingPolicy | Set-NicTeamingPolicy -MakeNicUnused $vmnic -Confirm:$false
    }
}
} #end of function
