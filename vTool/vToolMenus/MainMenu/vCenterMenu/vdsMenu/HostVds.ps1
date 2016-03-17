
#start of function
Function HostVds 
{
<#
.SYNOPSIS
    Add Esxi host to distributed switch.
.DESCRIPTION
    This will create a csv file whcih is opened in excel. Once you popuate the details, you have to save & close it. 
    Hit return/enter to proceed and the script will 
    add the esxi hosts to a chosen dvswitch.    
.NOTES
    File Name      : HostVds.ps1
    Author         : gajendra d ambi
    Date           : March 2016
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
$csv = "$PSScriptRoot/HostVds.csv"
get-process | Select-Object dvSwitch,hostname,vmnic | Export-Csv -Path $csv -Encoding ASCII -NoTypeInformation
Start-Process $csv
Read-Host "Hit Enter/Return to proceed"

$csv = Import-Csv $csv
 foreach ($line in $csv) 
 {
  $dvs    = $($line.dvSwitch)
  $vmhost = $($line.hostname)  
  $vmnic  = $($line.vmnic)  
  Get-VDSwitch -Name $dvs | Add-VDSwitchVMHost -VMHost $vmhost
  $vmhostNetworkAdapter = Get-VMHost $vmhost | Get-VMHostNetworkAdapter -Physical -Name $vmnic
  Get-VDSwitch $dvs | Add-VDSwitchPhysicalNetworkAdapter -VMHostNetworkAdapter $vmhostNetworkAdapter
 }

#End of Script
}#End of function


