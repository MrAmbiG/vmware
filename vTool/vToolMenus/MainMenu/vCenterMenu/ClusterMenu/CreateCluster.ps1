#start of function
Function CreateCluster 
{
<#
.SYNOPSIS
    Create CreateCluster DRS Rule.
.DESCRIPTION
    This uses custom functions to create DRS CreateCluster rules between VMs where VMs will be made to stay on the same host by the DRS.
.NOTES
    File Name      : CreateCluster.ps1
    Author         : gajendra d ambi
    Date           : March 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>

#Start of Script
$stopWatch = [system.diagnostics.stopwatch]::startNew()
$stopWatch.Start()

 $cluster = Read-Host "Name of the Cluster?"
 if ((Get-datacenter).count -gt 1) {
 $dc      = Read-Host "name of the datacenter?"
 get-datacenter -Name $dc | New-Cluster -Name $cluster -Confirm:$false
 }

 if ((Get-datacenter).count -eq 1) {
 get-datacenter | New-Cluster -Name $cluster -Confirm:$false
 }

 if ((Get-datacenter).count -eq 0) {
 Write-Host "Please create a datacenter first" -ForegroundColor DarkYellow -BackgroundColor White
 }

$stopWatch.Stop()
Write-Host "Elapsed Runtime:" $stopWatch.Elapsed.Hours "Hours" $stopWatch.Elapsed.Minutes "minutes and" $stopWatch.Elapsed.Seconds "seconds." -BackgroundColor White -ForegroundColor Black
#End of Script
} #End of function