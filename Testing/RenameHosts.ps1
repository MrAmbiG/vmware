#start of function
Function RenameHosts 
{
<#
.SYNOPSIS
    Rename Hosts by accessing them via ip address.
.DESCRIPTION
    This will
.NOTES
    File Name      : RenameHosts.ps1
    Author         : gajendra d ambi
    Date           : June 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>

#Start of Script
Write-Host "
A CSV file will be opened (open in excel/spreadsheet)
populate the values,
save & close the file,
Hit Enter to proceed
" -ForegroundColor Blue -BackgroundColor White
$csv = "$PSScriptRoot/IPhosts.csv"
get-process | Select-Object IP,Hostname,DomainName,username,password | Export-Csv -Path $csv -Encoding ASCII -NoTypeInformation
Start-Process $csv
Read-Host "Hit Enter/Return to proceed"

$csv = Import-Csv $csv
 foreach ($line in $csv) 
 {
  $IP         = $($IP.IP)
  $Hostname   = $($line.Hostname)
  $DomainName = $($line.DomainName)
  $username   = $($line.username)
  $password   = $($line.password)
  
  Connect-VIServer $IP -User $username -Password $password #connect to the esxi host
  $esxcli      = get-vmhost $ip | get-esxcli -V2
  $args        = $esxcli.system.hostname.set.CreateArgs()
  $args.host   = $hostname
  $args.domain = $domain
  $args.fqdn   = $hostname.$domain
  $esxcli.system.hostname.set.Invoke($args)
  Disconnect-VIServer $IP -Confirm:$false #disconnect from the esxi host
 }
#End of Script
} #End of function
RenameHosts