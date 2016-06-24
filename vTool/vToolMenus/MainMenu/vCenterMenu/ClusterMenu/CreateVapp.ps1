
#start of function
Function CreateVapp 
{
<#
.SYNOPSIS
    Create new vApp.
.DESCRIPTION
    This will create vApp in a cluster. It is very easy and less time consuming to do manually but
    the motto here is 'manual is an evil when you are automating' and most importantly in future this might have more options where
    you can add VMs and control the startup/shutdown order of VMs.
.NOTES
    File Name      : CreateVapp.ps1
    Author         : gajendra d ambi
    Date           : March 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>

#Start of Script
$cluster = Read-Host "name of the cluster?"
$vapp    = Read-Host "Name of the vApp?"

$stopWatch = [system.diagnostics.stopwatch]::startNew()
$stopWatch.Start()

New-VApp -Name $vapp -Location (get-cluster $cluster) -Confirm:$false

$stopWatch.Stop()
Write-Host "Elapsed Runtime:" $stopWatch.Elapsed.Hours "Hours" $stopWatch.Elapsed.Minutes "minutes and" $stopWatch.Elapsed.Seconds "seconds." -BackgroundColor White -ForegroundColor Black
#End of Script
}#End of function
