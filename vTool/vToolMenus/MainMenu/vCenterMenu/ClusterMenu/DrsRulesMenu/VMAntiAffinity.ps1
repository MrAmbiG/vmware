#start of function
Function VMAntiAffinity 
{
<#
.SYNOPSIS
    Create VMAntiAffinity DRS Rule.
.DESCRIPTION
    This uses custom functions to create DRS VMAntiAffinity rules between VMs where VMs will be made to stay on different hosts by the DRS.
.NOTES
    File Name      : VMAntiAffinity.ps1
    Author         : gajendra d ambi
    Date           : February 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>

#Start of Script
$cluster = Read-Host "Name of the Cluster?"
$drsrule = Read-Host "Type the Name of the DRS Rule"
$vms     = Read-Host "Name of the VMs (separated by comma, no space)?"
$vms     = $vms.split(',')

$stopWatch = [system.diagnostics.stopwatch]::startNew()
$stopWatch.Start()

New-DrsRule –Name $drsrule -Cluster $cluster –KeepTogether $false –VM $vms

$stopWatch.Stop()
Write-Host "Elapsed Runtime:" $stopWatch.Elapsed.Hours "Hours" $stopWatch.Elapsed.Minutes "minutes and" $stopWatch.Elapsed.Seconds "seconds." -BackgroundColor White -ForegroundColor Black
#End of Script
}#End of function