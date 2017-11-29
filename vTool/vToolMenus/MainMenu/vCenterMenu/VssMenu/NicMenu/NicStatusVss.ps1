#start of function
function NicStatusVss
{
<#
.SYNOPSIS
    Change nic teaming of nics.
.DESCRIPTION
    This will change the nic status on vSwitchs
.NOTES
    File Name      : NicStatusVss.ps1
    Author         : gajendra d ambi
    Date           : July 2016
    Prerequisite   : PowerShell v4+, powercli 6.3+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/MrAmbiG/vmware
#>

#Start of Script
$cluster = Read-Host "cluster[type * to include all clusters]?"
$vss     = Read-Host "vSphere standard Switch?"
$nic     = Read-Host "vmnic (ex:vmnic5)?"

Write-host "
1 . Add Nic
2 . Remove Nic
3 . MakeNicActive
4 . MakeNicStandby
5 . MakeNicUnused
" -BackgroundColor white -ForegroundColor black
Write-Host choose from 1 to 5 from above -BackgroundColor Yellow -ForegroundColor Black
$option = Read-Host " "


$stopWatch = [system.diagnostics.stopwatch]::startNew()
$stopWatch.Start()

$vmhosts = get-cluster $cluster | get-vmhost | sort
foreach ($vmhost in $vmhosts)
{
$vmnic = get-vmhost $vmhost | Get-VMHostNetworkAdapter -Physical -Name $nic
    if ($option -eq 1 ) 
    {
    #add vmnic
    get-vmhost $vmhost | get-virtualswitch -Name $vss | Add-VirtualSwitchPhysicalNetworkAdapter -VMHostPhysicalNic $vmnic -confirm:$false
    get-vmhost $vmhost | get-virtualswitch -Name $vss | Get-NicTeamingPolicy
    }
    
    if ($option -eq 2 ) 
    {
    #remove vmnic
    get-vmhost $vmhost | Get-VMHostNetworkAdapter -Physical -Name $nic | Remove-VirtualSwitchPhysicalNetworkAdapter -confirm:$false
    get-vmhost $vmhost | get-virtualswitch -Name $vss | Get-NicTeamingPolicy
    }
    
    if ($option -eq 3 ) 
    {
    #Make active
    Get-VMHost $vmhost | get-virtualswitch -Name $vss | Get-NicTeamingPolicy | Set-NicTeamingPolicy -MakeNicActive $vmnic -confirm:$false
    }
    
    if ($option -eq 4 ) 
    {
    #make standby
    Get-VMHost $vmhost | get-virtualswitch -Name $vss | Get-NicTeamingPolicy | Set-NicTeamingPolicy -MakeNicStandby $vmnic -confirm:$false
    }
    
    if ($option -eq 5 ) 
    {
    #make unused
    Get-VMHost $vmhost | get-virtualswitch -Name $vss | Get-NicTeamingPolicy | Set-NicTeamingPolicy -MakeNicUnused $vmnic -confirm:$false
    }
}
$stopWatch.Stop()
Write-Host "Elapsed Runtime:" $stopWatch.Elapsed.Hours "Hours" $stopWatch.Elapsed.Minutes "minutes and" $stopWatch.Elapsed.Seconds "seconds." -BackgroundColor White -ForegroundColor Black
 #End of Script#
}#End of function