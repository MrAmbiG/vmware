#start of function
Function AddDpg 
{
<#
.SYNOPSIS
    Add dvportgroups to a dvswitch.
.DESCRIPTION
    This will create a csv file whcih is opened in excel. Once you popuate the details, you have to save & close it. 
    Hit return/enter to proceed and the script will 
    add the dvportgroups to a chosen dvswitch.    
.NOTES
    File Name      : AddDpg.ps1
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

$stopWatch = [system.diagnostics.stopwatch]::startNew()
$stopWatch.Start()

$csv = "$PSScriptRoot/AddDpg.csv"
get-process | Select-Object dvSwitch,dvPortgroup,VlanId,NumberOfPorts | Export-Csv -Path $csv -Encoding ASCII -NoTypeInformation
Start-Process $csv
Read-Host "Hit Enter/Return to proceed"

$csv = Import-Csv $csv
 foreach ($line in $csv) 
 {
  $dvs    = $($line.dvSwitch)
  $dpg    = $($line.dvPortgroup)
  $vlan   = $($line.VlanId)
  $ports  = $($line.NumberOfPorts)
  Get-VDSwitch -Name $dvs | New-VDPortgroup -Name $dpg -VlanId $vlan -NumPorts $ports
 }

$stopWatch.Stop()
Write-Host "Elapsed Runtime:" $stopWatch.Elapsed.Hours "Hours" $stopWatch.Elapsed.Minutes "minutes and" $stopWatch.Elapsed.Seconds "seconds." -BackgroundColor White -ForegroundColor Black
 #End of Script#
}#End of function