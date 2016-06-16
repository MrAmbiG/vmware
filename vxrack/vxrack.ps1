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

#Get Plink
$PlinkLocation = $PSScriptRoot + "\Plink.exe" #http://www.virtu-al.net/2013/01/07/ssh-powershell-tricks-with-plink-exe/
If (-not (Test-Path $PlinkLocation)){
   Write-Host "Plink.exe not found, trying to download..."
   $WC = new-object net.webclient
   $WC.DownloadFile("http://the.earth.li/~sgtatham/putty/latest/x86/plink.exe",$PlinkLocation)
   If (-not (Test-Path $PlinkLocation)){
      Write-Host "Unable to download plink.exe, please download and add it to the same folder as this script"
      Exit
   } Else {
      $PlinkEXE = Get-ChildItem $PlinkLocation
      If ($PlinkEXE.Length -gt 0) {
         Write-Host "Plink.exe downloaded, continuing script"
      } Else {
      Write-Host "Unable to download plink.exe, please download and add it to the same folder as this script"
         Exit
      }
   }  
}

Write-Host "
A CSV file will be opened (open in excel/spreadsheet)
populate the values,
save & close the file,
Hit Enter to proceed
" -ForegroundColor Blue -BackgroundColor White
$csv = "$PSScriptRoot/vxrack.csv"
get-process | Select-Object IP,Hostname,DomainName,username,password | Export-Csv -Path $csv -Encoding ASCII -NoTypeInformation
Start-Process $csv
Read-Host "Hit Enter/Return to proceed"

$csv = Import-Csv $csv
 foreach ($line in $csv) 
 {
  $cluster = $($line.IP)
  $vmhost  = $($line.Hostname)
  $user    = $($line.DomainName)
  $pass    = $($line.username)
  $pass    = $($line.password)
  Add-VMHost $vmhost -Location (get-cluster -Name $cluster) -User $user -Password $pass -Force -Confirm:$false 
 }
#End of Script
} #End of function