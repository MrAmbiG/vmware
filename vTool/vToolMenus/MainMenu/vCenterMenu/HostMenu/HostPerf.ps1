#start of function
Function HostPerf 
{
<#
.SYNOPSIS
    Set esxi host performance level
.DESCRIPTION
    This will change the host's performance level to the following.
.NOTES
    File Name      : VssPmOn.ps1
    Author         : gajendra d ambi
    Date           : August 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#Start of Script
$cluster = Read-Host "name of the cluster[type * to include all clusters]?"
Write-Host "choose a number from below
1. High performance
2. Balanced
3. LowPower
" -BackgroundColor White -ForegroundColor Black
$option = Read-Host "?"

$stopWatch = [system.diagnostics.stopwatch]::startNew()
$stopWatch.Start()

foreach ($vmhost in (get-cluster $cluster | get-vmhost | sort)) 
{$vmhost.Name
(Get-View (Get-VMHost $vmhost | Get-View).ConfigManager.PowerSystem).ConfigurePowerPolicy($option)
}

$stopWatch.Stop()
Write-Host "Elapsed Runtime:" $stopWatch.Elapsed.Hours "Hours" $stopWatch.Elapsed.Minutes "minutes and" $stopWatch.Elapsed.Seconds "seconds." -BackgroundColor White -ForegroundColor Black
 #End of Script#
}#End of function