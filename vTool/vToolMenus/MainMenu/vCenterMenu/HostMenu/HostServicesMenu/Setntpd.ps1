#start of function
function Setntpd 
{
<#
.SYNOPSIS
    Configure ntpd [NTP Daemon]
.DESCRIPTION
    Depending upon the choice that you make
    This will enable ntpd.
    This will disable ntpd.
    This will set ntpd policy to On which will be persistent across reboot.
    This will set ntpd policy to Off which will be persistent across reboot.
.NOTES
    File Name      : Setntpd.ps1
    Author         : gajendra d ambi
    Date           : March 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#Start of script#
$cluster = Read-Host "name of the cluster[type * to include all clusters]?"
Write-Host "ntpd [NTP Daemon] options
     1. Enable ntpd
     2. Disable ntpd
     3. ntpd Policy On
     4. ntpd Policy Off
     " -BackgroundColor White -ForegroundColor Blue #options to choose from
 $a = Read-Host "Choose a number from 1 to 4"
 if ($a -eq 1) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ ntpd | Start-VMHostService -Confirm:$false}
 if ($a -eq 2) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ ntpd | stop-VMHostService -Confirm:$false}
 if ($a -eq 3) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ ntpd | Set-VMHostService -Policy On -Confirm:$false}
 if ($a -eq 4) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ ntpd | Set-VMHostService -Policy Off -Confirm:$false}
    
 #End of Script#
}#End of function