#Start of function
function IpChanger 
{
<#
.SYNOPSIS
    Changes the ip address and gateway of the given vmkernel
.DESCRIPTION
    needs plink.exe to be copied to root directory. If you have not run this command windows as an administrator
    then you have to copy it manually to the C:/ drive. It will launch a CSV file, populate those details. save the file.
    proceed with the script. script will enable ssh, change the ip and gateway as per your input and close the ssh.
.NOTES
    File Name      : IpChanger.ps1
    Author         : gajendra d ambi
    updated        : July 2017
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/MrAmbig
#>
#Start of Script
GetPlink #custom function
Copy-Item $PSScriptRoot\plink.exe C:\ #copy plink to c:\ for now

Write-Host "
A CSV file will be opened (open in excel/spreadsheet)
populate the values,
save & close the file,
Hit Enter to proceed
" -ForegroundColor Blue -BackgroundColor White
$csv = "$PSScriptRoot/HostVds.csv"
get-process | Select-Object OldIp,NewIp,username,password,VMK,subnetMask | Export-Csv -Path $csv -Encoding ASCII -NoTypeInformation
Start-Process $csv
Read-Host "Hit Enter/Return to proceed"

$csv = Import-Csv $csv

  foreach ($line in $csv) 
 {  
  $OldIp = $($line.OldIp)  
  $user  = $($line.username)  
  $pass  = $($line.password)
  connect-viserver $OldIp -user $user -password $pass   
  }
  Get-VMHost | Get-VMHostService | where {$_.Key -eq "TSM-SSH"} | Start-VMHostService -confirm:$false #start ssh
  Disconnect-VIServer * -Confirm:$false

 foreach ($line in $csv) 
 {
  $OldIp = $($line.OldIp)
  $NewIp = $($line.NewIp)  
  $user  = $($line.username)  
  $pass  = $($line.password)
  $VMK = $($line.VMK)
  $subnetMask = $($line.subnetMask)
  
  echo y | C:\plink.exe -ssh $user@$OldIp -pw $pass "exit" #store ssh keys

  $commands = "$PSScriptRoot\commands.txt" #create text file
  if ((Test-Path $commands) -eq "True") {ri $commands -Force -Confirm:$false } #remove old text report file
  ni -ItemType file $commands -Force
  add-content $commands "esxcli network ip interface ipv4 set -i $VMK -I $NewIp -N $subnetMask -t static"
    
  C:\plink.exe -ssh -v -noagent $OldIp -l $user -pw $pass -m $commands  
 }

  foreach ($line in $csv) 
 {  
  $NewIp = $($line.NewIp)  
  $user  = $($line.username)  
  $pass  = $($line.password)
  connect-viserver $NewIp -user $user -password $pass 
  }
  Get-VMHost | Get-VMHostService | where {$_.Key -eq "TSM-SSH"} | Stop-VMHostService -confirm:$false #start ssh 

 } #End of function