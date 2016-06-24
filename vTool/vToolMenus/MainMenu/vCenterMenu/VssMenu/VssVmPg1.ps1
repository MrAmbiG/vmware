
#start of function
Function VssVmPg1
{
<#
.SYNOPSIS
    update virtual machine portgroup on vSwitch.
.DESCRIPTION
    This will update virtual machie portgroup on a chosen standard vSwitch of hosts of a chosen cluster.    
.NOTES
    File Name      : VssVmPg1.ps1
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
$csv = "$PSScriptRoot/VssVmPg1.csv"
get-process | Select-Object VMHost,vSwitch,Portgroup,vlan | Export-Csv -Path $csv -Encoding ASCII -NoTypeInformation
Start-Process $csv
Read-Host "Hit Enter/Return to proceed"

$TimeStart = Get-Date #start time
$TimeEnd   = Get-Date #end time
$TimeTaken = $TimeEnd - $TimeStart #total time taken
$TimeStart #starting the timer

$csv = Import-Csv $csv
 foreach ($line in $csv) 
 {
  $vmhost = $($line.VMHost)
  $vss    = $($line.vSwitch)
  $pg     = $($line.Portgroup)
  $vlan   = $($line.vlan)
  Get-VMHost $vmhost | Get-VirtualSwitch -Name $vss | New-VirtualPortGroup -Name $pg -VLanId $vlan -Confirm:$false
 }

$TimeEnd #stopping the timer
Write-Host "Time taken - $TimeTaken" -BackgroundColor White -ForegroundColor blue #total time taken
 #End of Script#
}#End of function