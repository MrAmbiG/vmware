#start of function
Function ConfigDrs 
{
<#
.SYNOPSIS
    Configure DRS on the cluster.
.DESCRIPTION
    This will configure DRS on a specified cluster.
.NOTES
    File Name      : ConfigDrs.ps1
    Author         : gajendra d ambi
    Date           : March 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>

#Start of Script

$cluster = Read-Host "name of the cluster?"
Write-Host "
choose the DRS Mode
1. FullyAutomated
2. Manual
3. PartiallyAutomated
" -ForegroundColor Blue -BackgroundColor White
$DrsLevel = Read-Host "type 1 or 2 or 3"

$stopWatch = [system.diagnostics.stopwatch]::startNew()
$stopWatch.Start()

if ($DrsLevel -eq 1) { $DrsLevel = "FullyAutomated" }
if ($DrsLevel -eq 2) { $DrsLevel = "Manual" }
if ($DrsLevel -eq 3) { $DrsLevel = "PartiallyAutomated" }

Get-Cluster $cluster | Set-Cluster -DrsEnabled:$true -DrsAutomationLevel $DrsLevel -confirm:$false

$stopWatch.Stop()
Write-Host "Elapsed Runtime:" $stopWatch.Elapsed.Hours "Hours" $stopWatch.Elapsed.Minutes "minutes and" $stopWatch.Elapsed.Seconds "seconds." -BackgroundColor White -ForegroundColor Black
#End of Script
}#End of function
