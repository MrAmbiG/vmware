#start of function
function Setsnmpd 
{
<#
.SYNOPSIS
    Configure snmpd [SNMP Server]
.DESCRIPTION
    Depending upon the choice that you make
    This will enable snmpd.
    This will disable snmpd.
    This will set snmpd policy to On which will be persistent across reboot.
    This will set snmpd policy to Off which will be persistent across reboot.
.NOTES
    File Name      : Setsnmpd.ps1
    Author         : gajendra d ambi
    Date           : March 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#Start of script#
$cluster = Read-Host "name of the cluster[type * to include all clusters]?"
Write-Host "snmpd [SNMP Server] options
     1. Enable snmpd
     2. Disable snmpd
     3. snmpd Policy On
     4. snmpd Policy Off
     " -BackgroundColor White -ForegroundColor Blue #options to choose from
 $a = Read-Host "Choose a number from 1 to 4"
 if ($a -eq 1) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ snmpd | Start-VMHostService -Confirm:$false}
 if ($a -eq 2) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ snmpd | stop-VMHostService -Confirm:$false}
 if ($a -eq 3) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ snmpd | Set-VMHostService -Policy On -Confirm:$false}
 if ($a -eq 4) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ snmpd | Set-VMHostService -Policy Off -Confirm:$false}
    
 #End of Script#
}#End of function