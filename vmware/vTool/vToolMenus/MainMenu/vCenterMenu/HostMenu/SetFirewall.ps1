#start of function
function SetFirewall 
{
<#
.SYNOPSIS
    firewall settings for esxi hosts
.DESCRIPTION
    Configure firewall per host in a cluster. These is a sample firewall setting here. You can populate the rest as per your business
    standards. Run 
    get-vmhost <name of any esxi host> | Get-VmhostFirewallException
    to list the available firewall settings that you can turn on or off.
.NOTES
    File Name      : SetFirewall.ps1
    Author         : gajendra d ambi
    Date           : March 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#Start of script#

$stopWatch = [system.diagnostics.stopwatch]::startNew()
$stopWatch.Start()

$cluster = Read-Host "name of the cluster[type * to include all clusters]?"

 foreach ($vmhost in (Get-Cluster $cluster)) 
 {
  Get-VMHost $vmhost | Get-VmhostFirewallException -Name "NTP Client" | Set-VMHostFirewallException -enabled:$true -Confirm:$false
 }

$stopWatch.Stop()
Write-Host "Elapsed Runtime:" $stopWatch.Elapsed.Hours "Hours" $stopWatch.Elapsed.Minutes "minutes and" $stopWatch.Elapsed.Seconds "seconds." -BackgroundColor White -ForegroundColor Black
#End of Script#
}#End of function