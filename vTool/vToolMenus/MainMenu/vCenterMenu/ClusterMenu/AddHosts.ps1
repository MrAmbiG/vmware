#start of function
Function AddHosts 
{
<#
.SYNOPSIS
    Add hosts to cluster.
.DESCRIPTION
    This will add hosts to the specified clusters. The function will create a csv file which can be opened in excel.
    populate the values under their respective headers in the excel. save it. close it. Hit return/enter to proceed.
    Then the script will use the values from csv file and add hosts to the cluster(s).
.NOTES
    File Name      : AddHosts.ps1
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
$csv = "$PSScriptRoot/addhosts.csv"
get-process | Select-Object cluster,hostname,username,password | Export-Csv -Path $csv -Encoding ASCII -NoTypeInformation
Start-Process $csv
Read-Host "Hit Enter/Return to proceed"

$stopWatch = [system.diagnostics.stopwatch]::startNew()
$stopWatch.Start()

$csv = Import-Csv $csv
 foreach ($line in $csv) 
 {
  $cluster = $($line.cluster)
  $vmhost  = $($line.hostname)
  $user    = $($line.username)
  $pass    = $($line.password)
  Add-VMHost $vmhost -Location (get-cluster -Name $cluster) -User $user -Password $pass -Force -Confirm:$false 
 }

$stopWatch.Stop()
Write-Host "Elapsed Runtime:" $stopWatch.Elapsed.Hours "Hours" $stopWatch.Elapsed.Minutes "minutes and" $stopWatch.Elapsed.Seconds "seconds." -BackgroundColor White -ForegroundColor Black
#End of Script
} #End of function