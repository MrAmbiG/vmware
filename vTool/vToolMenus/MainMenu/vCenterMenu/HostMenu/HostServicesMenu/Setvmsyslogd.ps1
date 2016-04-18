#start of function
function Setvmsyslogd 
{
<#
.SYNOPSIS
    Configure vmsyslogd [Syslog Server]
.DESCRIPTION
    Depending upon the choice that you make
    This will enable vmsyslogd.
    This will disable vmsyslogd.
    This will set vmsyslogd policy to On which will be persistent across reboot.
    This will set vmsyslogd policy to Off which will be persistent across reboot.
.NOTES
    File Name      : Setvmsyslogd.ps1
    Author         : gajendra d ambi
    Date           : March 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#Start of script#
$cluster = Read-Host "name of the cluster[type * to include all clusters]?"
Write-Host "vmsyslogd [Syslog Server] options
     1. Enable vmsyslogd
     2. Disable vmsyslogd
     3. vmsyslogd Policy On
     4. vmsyslogd Policy Off
     " -BackgroundColor White -ForegroundColor Blue #options to choose from
 $a = Read-Host "Choose a number from 1 to 4"
 if ($a -eq 1) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ vmsyslogd | Start-VMHostService -Confirm:$false}
 if ($a -eq 2) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ vmsyslogd | stop-VMHostService -Confirm:$false}
 if ($a -eq 3) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ vmsyslogd | Set-VMHostService -Policy On -Confirm:$false}
 if ($a -eq 4) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ vmsyslogd | Set-VMHostService -Policy Off -Confirm:$false}
    
 #End of Script#
}#End of function