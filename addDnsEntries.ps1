function addDnsEntries {
<#
.SYNOPSIS
    add dns entries to microsoft dns server
.DESCRIPTION
    This will create a csv file with the headers. Fill the details and hit enter.
    Then the script will add the dns entries.
.NOTES
    File Name      : addDnsEntries.ps1
    Author         : Gajendra d ambi
    updated        : November 2017
    Prerequisite   : PowerShell v4+ win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/MrAmbig/
#>
Write-Host "make sure you are running it on dns server"

Write-Host "
A CSV file will be opened (open in excel/spreadsheet)
populate the values,
save & close the file,
Hit Enter to proceed
" -ForegroundColor Blue -BackgroundColor White
$csv = "$PSScriptRoot/HostVds.csv"
get-process | Select-Object netbiosName,ip,zone | Export-Csv -Path $csv -Encoding ASCII -NoTypeInformation
Start-Process $csv
Read-Host "Hit Enter/Return to proceed"

$csv = Import-Csv $csv

foreach ($line in $csv) 
    {  # importing data from csv and go line by line
    $hostname = $($line.netbiosName)  
    $ip  = $($line.ip)  
    $zone  = $($line.zone)
    add-dnsserverresourcerecordA -name $hostname -ipv4address $ip -zonename $zone -createptr
    }
} addDnsEntries