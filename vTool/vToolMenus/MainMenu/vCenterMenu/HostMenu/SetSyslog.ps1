#start of function
function SetSyslog 
{
<#
.SYNOPSIS
    Configure Syslog
.DESCRIPTION
    This will configure Syslog using powercli. This only set the syslog servers and enable syslog on the esxi hosts.
    You may however include additional advanced syslog configuarations like Syslog.global.defaultSize and others.
    This will also create a firewall exception for the syslog.
.NOTES
    File Name      : SetSyslog.ps1
    Author         : gajendra d ambi
    Date           : March 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#Start of script#
$cluster = Read-Host "name of the cluster[type * to include all clusters]?"
$syslog  = Read-Host "Syslog Target?"

foreach ($vmhost in (get-cluster $cluster | get-vmhost | sort)) {
get-vmhost $vmhost | Get-AdvancedSetting -Name Syslog.global.logHost | Set-AdvancedSetting -Value $Syslog -Confirm:$false
get-vmhost $vmhost | Get-VMHostFirewallException -Name "syslog" | Set-VMHostFirewallException -enabled:$true -Confirm:$false
  }#End of Script#
}#End of function