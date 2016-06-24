#start of function
function SetDNS 
{
<#
.SYNOPSIS
    Update DNS
.DESCRIPTION
    This will update the DNS, domain and searchdomain for the esxi hosts.
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
Write-Host "This new values will replace the existing values, hence add all the values" -ForegroundColor Yellow 
$dnsadd  = Read-Host "DNS Addresses(separate multiple entries with a comma)?"
$dnsadd  = $dnsadd.split(',')
$domain  = Read-Host "domain name?"

$stopWatch = [system.diagnostics.stopwatch]::startNew()
$stopWatch.Start()

get-cluster $cluster | get-vmhost | Get-VMHostNetwork | Set-VMHostNetwork -DnsAddress $dnsadd -DomainName $domain -SearchDomain $domain -Confirm:$false

$stopWatch.Stop()
Write-Host "Elapsed Runtime:" $stopWatch.Elapsed.Hours "Hours" $stopWatch.Elapsed.Minutes "minutes and" $stopWatch.Elapsed.Seconds "seconds." -BackgroundColor White -ForegroundColor Black
#End of Script#
}#End of function