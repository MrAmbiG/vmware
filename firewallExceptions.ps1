<#
.SYNOPSIS
    some essential firewall settings
.DESCRIPTION
    this will enable the following firewall exceptions
    netDump
    syslog
    SSH Client
    NTP Client
    vCenter Update Manager
.NOTES
    File Name      : firewallSettings.ps1
    Author         : gajendra d ambi
    updated        : June 2017
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/MrAmbig/vmware
#>
$vc = read-host 'vcenter address?'
Connect-VIServer $vc
foreach ($esxi in (Get-vmhost)){
get-vmhostfirewallexception -VMHost $esxi -Name "netDump" | Set-VMHostFirewallException -enabled:$true
get-vmhostfirewallexception -VMHost $esxi -Name "syslog" | Set-VMHostFirewallException -enabled:$true
get-vmhostfirewallexception -VMHost $esxi -Name "SSH Client" | Set-VMHostFirewallException -enabled:$true
get-vmhostfirewallexception -VMHost $esxi -Name "NTP Client" | Set-VMHostFirewallException -enabled:$true
get-vmhostfirewallexception -VMHost $esxi -Name "vCenter Update Manager" | Set-VMHostFirewallException -enabled:$true
}