
#start of function
Function PgRename 
{
<#
.SYNOPSIS
    update virtual machine portgroup's name on vSwitch.
.DESCRIPTION
    This will update virtual machine portgroup's name on a chosen standard vSwitch of hosts of a chosen cluster.    
.NOTES
    File Name      : PgRename.ps1
    Author         : gajendra d ambi
    Date           : March 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#Start of Script
$cluster = Read-Host "name of the cluster[type * to include all clusters]?"
$oldpg   = Read-Host "Old Name of the portgroup?"
$newpg   = Read-Host "New Name of the portgroup?"

$stopWatch = [system.diagnostics.stopwatch]::startNew()
$stopWatch.Start()

Get-cluster $cluster | Get-VMHost | Get-VirtualPortGroup -Name $oldpg | Set-VirtualPortGroup -Name $newpg -Confirm:$false

$stopWatch.Stop()
Write-Host "Elapsed Runtime:" $stopWatch.Elapsed.Hours "Hours" $stopWatch.Elapsed.Minutes "minutes and" $stopWatch.Elapsed.Seconds "seconds." -BackgroundColor White -ForegroundColor Black
 #End of Script#
}#End of function