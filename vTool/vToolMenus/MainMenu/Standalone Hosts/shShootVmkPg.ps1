#start of function
function shShootVmkPg 
{
<#
.SYNOPSIS
    Create New VMware Standard Switch on all hosts
.DESCRIPTION
    This will need the 1st host's ip address and the number of subsequent hosts that you want to configure(which should be in series of the ip address).
    Lets say you have 10 esxi hosts and the 1st host's ip is 1.1.1.1 then you have to provide the 1st host's ip address and the number of hosts
    as an input to this script which will do +1 to the last octet of the 1st host's ip address and connect to all the 10 hosts and 
    Then it will Remove vmkernel portgroup.
.NOTES
    File Name      : ShootVmkPg.ps1
    Author         : gajendra d ambi
    Date           : April 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#Start of script#
$pg      = Read-Host "Name of the portgroup?"

$stopWatch = [system.diagnostics.stopwatch]::startNew()
$stopWatch.Start()

 foreach ($vmhost in (get-vmhost | sort)) 
 {
  $vmk = Get-VMHostNetworkAdapter -VMHost $vmhost | where PortgroupName -eq $pg
  Write-Host "removing vmkernel from the $pg on $vmhost"
  Remove-VMHostNetworkAdapter -Nic $vmk -confirm:$false
 
  Write-Host "removing $pg on $vmhost"
  get-vmhost $vmhost | get-virtualportgroup -Name $pg | Remove-VirtualPortGroup -Confirm:$false 

$stopWatch.Stop()
Write-Host "Elapsed Runtime:" $stopWatch.Elapsed.Hours "Hours" $stopWatch.Elapsed.Minutes "minutes and" $stopWatch.Elapsed.Seconds "seconds." -BackgroundColor White -ForegroundColor Black
 }#End of Script#
}#End of function