 
#start of function
Function ConfigHA 
{
<#
.SYNOPSIS
    Configure HA on the cluster.
.DESCRIPTION
    This will configure Ha on a specified cluster. It will
    enable HA
    disable admission control if the number of hosts is less than or equal to 3
    set the vm monitoring policy.
.NOTES
    File Name      : ConfigHA.ps1
    Author         : gajendra d ambi
    Date           : March 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>

#Start of Script

$cluster = Read-Host "name of the cluster?"
$HARestartPriority = Read-Host "
choose one of the following as your VM (HA) Restart Priority
0. ClusterRestartPriority
1. Disabled
2. Low
3. Medium (Recommended)
4. High
" -ForegroundColor Blue -BackgroundColor White

$stopWatch = [system.diagnostics.stopwatch]::startNew()
$stopWatch.Start()

get-cluster $cluster | Set-Cluster -HAEnabled:$true

if ($HARestartPriority -eq 0 ) { get-cluster $cluster | set-cluster -HARestartPriority ClusterRestartPriority -Confirm:$false }
if ($HARestartPriority -eq 1 ) { get-cluster $cluster | set-cluster -HARestartPriority Disabled               -Confirm:$false }
if ($HARestartPriority -eq 2 ) { get-cluster $cluster | set-cluster -HARestartPriority Low                    -Confirm:$false }
if ($HARestartPriority -eq 3 ) { get-cluster $cluster | set-cluster -HARestartPriority Medium                 -Confirm:$false }
if ($HARestartPriority -eq 4 ) { get-cluster $cluster | set-cluster -HARestartPriority High                   -Confirm:$false }

if ((Get-Cluster $cluster | Get-VMHost).count -lt 4) { Get-Cluster $cluster | Set-Cluster -HAAdmissionControlEnabled:$false }

$stopWatch.Stop()
Write-Host "Elapsed Runtime:" $stopWatch.Elapsed.Hours "Hours" $stopWatch.Elapsed.Minutes "minutes and" $stopWatch.Elapsed.Seconds "seconds." -BackgroundColor White -ForegroundColor Black
#End of Script
}#End of function