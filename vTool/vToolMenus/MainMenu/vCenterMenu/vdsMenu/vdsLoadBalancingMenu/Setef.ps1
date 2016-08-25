#start of function
Function Setef 
{
<#
.SYNOPSIS
    Set ExplicitFailover on VDS.
.DESCRIPTION
    This will set the loadbalancing on the vds as ExplicitFailover.
.NOTES
    File Name      : Setef.ps1
    Author         : gajendra d ambi
    Date           : March 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#Start of Script
$dvs = Read-Host "name of the dvSwitch?"

$stopWatch = [system.diagnostics.stopwatch]::startNew()
$stopWatch.Start()

Get-VDSwitch -Name $dvs | Get-VDUplinkTeamingPolicy | Set-VDUplinkTeamingPolicy -LoadBalancingPolicy ExplicitFailover -Confirm:$false

$stopWatch.Stop()
Write-Host "Elapsed Runtime:" $stopWatch.Elapsed.Hours "Hours" $stopWatch.Elapsed.Minutes "minutes and" $stopWatch.Elapsed.Seconds "seconds." -BackgroundColor White -ForegroundColor Black
 #End of Script#
}#End of function
