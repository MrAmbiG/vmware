#start of function
function SetDNS 
{
<#
.SYNOPSIS
    Update NTP
.DESCRIPTION
    This will update the NTP servers to the esxi hosts. It will add one NTP server at a time.
    It will not replace or overwrite any existing NTP servers. This will set the ntpd service to on.
.NOTES
    File Name      : SetDNS.ps1
    Author         : gajendra d ambi
    Date           : March 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#Start of script#
$cluster = Read-Host "name of the cluster[type * to include all clusters]?"
$ntp     = Read-Host "NTP address(put just one ntp address at a time, re run the same script to add more)"

 foreach ($vmhost in (Get-Cluster $cluster)) 
 {
 Write-Host "adding ntp server to $vmhost" -ForegroundColor Green
 Add-VMHostNTPServer -NtpServer $ntp -VMHost (Get-VMHost $vmhost) -Confirm:$false
 Write-Host "setting ntp policy to on on $vmhost" -ForegroundColor Green
 Get-VMHostService -VMHost (Get-VMHost $vmhost) | where Key -eq "ntpd" | Restart-VMHostService | Set-VMHostService -policy "on" -Confirm:$false
 }#End of Script#
}#End of function