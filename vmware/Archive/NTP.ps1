
<#
.SYNOPSIS
    Add NTP servers to esxi hosts
.DESCRIPTION
    This should help you add multiple ntp servers to the esxi hosts. if you want to add more than 2 then just re run the same script.
.NOTES
    File Name      : NTP.ps1
    Author         : gajendra d ambi
    Date           : June 2015
    Recommended    : Powercli 4.x, PowerShell V4 over windows 7 and upper.
    Copyright      - None
.LINK
    Script posted over:
    https://github.com/gajuambi/vmware
#>

$ntp1 = read-host "1st ntp server"
$ntp2 = read-host "2nd ntp server"

Add-VMHostNTPServer -NtpServer $ntp1 , $ntp2 -VMHost (Get-VMHost) -Confirm:$false
