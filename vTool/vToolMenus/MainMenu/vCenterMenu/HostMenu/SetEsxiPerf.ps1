#start of function
function SetEsxiPerf 
{
<#
.SYNOPSIS
    Configure powersaving policy or performance policy on esxi.
.DESCRIPTION
    This will configure 1 of the 3 levels of energy saving or performance setting on your esxi hosts.
    3 valid options are HighPerformance, Balanced, LowPower.
.NOTES
    File Name      : SetEsxiPerf.ps1
    Author         : gajendra d ambi
    Date           : March 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#Start of script#

$cluster = Read-Host "name of the cluster[type * to include all clusters]?"
Write-Host "
1. HighPerformance 
2. Balanced 
3. LowPower
" -ForegroundColor Blue -BackgroundColor White
$perf   = Read-Host "one of the following is a valid choice. Type 1,2 or 3"

$stopWatch = [system.diagnostics.stopwatch]::startNew()
$stopWatch.Start()

if ($perf -eq 1) {$perf = "HighPerformance"}
if ($perf -eq 2) {$perf = "Balanced"       }
if ($perf -eq 3) {$perf = "LowPower"       }

(Get-View (Get-Cluster $cluster | Get-VMHost | Get-View).ConfigManager.PowerSystem).ConfigurePowerPolicy($perf)

$stopWatch.Stop()
Write-Host "Elapsed Runtime:" $stopWatch.Elapsed.Hours "Hours" $stopWatch.Elapsed.Minutes "minutes and" $stopWatch.Elapsed.Seconds "seconds." -BackgroundColor White -ForegroundColor Black
#End of Script#
}#End of function