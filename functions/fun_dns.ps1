<#
.SYNOPSIS
    set DNS.
.DESCRIPTION
    Update DNS settings for esxi hosts
.NOTES
    File Name      : fun_dns.ps1
    Author         : gajendra d ambi
    Date           : January 2016
    recommended    : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware   
#>

#Start of script
#start of function
Function fun_dns {
 $dnsadd = Read-Host "Type the dns address (separate multiple addresses with a comma but no spaces):"
 $domain = Read-Host "Type the domain name:"
 get-vmhost | Get-VMHostNetwork | Set-VMHostNetwork -DnsAddress $dnsadd -DomainName $domain -SearchDomain $domain -Confirm:$false
}
#end of function
fun_dns
#End of script
