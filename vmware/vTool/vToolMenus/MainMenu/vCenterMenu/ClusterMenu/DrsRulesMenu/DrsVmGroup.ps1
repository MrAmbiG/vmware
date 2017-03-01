#start of function
Function DrsVmGroup 
{
<#
.SYNOPSIS
    Create DrsVmGroup DRS Rule.
.DESCRIPTION
    This uses custom functions to create DRS DrsVmGroup rules between VMs where VMs will be made to stay on the same host by the DRS.
.NOTES
    File Name      : DrsVmGroup.ps1
    Author         : gajendra d ambi
    Date           : February 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>

#Start of Script
$cluster     = Read-Host "Name of the Cluster?"
$VMs         = Read-Host "Type the Name of the VM/VMs (separated only by a comma and no spaces)"
$VMs         = $VMs.split(',')
$vmgroup     = Read-Host "Type the Name of the VM group"

$stopWatch = [system.diagnostics.stopwatch]::startNew()
$stopWatch.Start()

Get-VM $VMs | New-DrsVmGroup -Name $vmgroup -Cluster $cluster

$stopWatch.Stop()
Write-Host "Elapsed Runtime:" $stopWatch.Elapsed.Hours "Hours" $stopWatch.Elapsed.Minutes "minutes and" $stopWatch.Elapsed.Seconds "seconds." -BackgroundColor White -ForegroundColor Black
#End of Script#
}#End of function