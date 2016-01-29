<#
.SYNOPSIS
    set NTP.
.DESCRIPTION
    Update ntp settings for esxi hosts
.NOTES
    File Name      : fun_ntp.ps1
    Author         : gajendra d ambi
    Date           : January 2016
    recommended    : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware   
#>

#Start of script
#start of function
Function fun_ntp {
 write-host "Type 1 ntp server, Rerun the same script to add another ntp server"
 $ntp = Read-Host
 Add-VMHostNTPServer -NtpServer $ntp -VMHost (Get-VMHost) -Confirm:$false
 Get-VMHostService -VMHost (Get-VMHost) | where Key -eq "ntpd" | Restart-VMHostService | Set-VMHostService -policy "on" -Confirm:$false
}
#end of function
fun_ntp
#End of script
