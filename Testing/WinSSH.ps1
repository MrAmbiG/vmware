#start of function
Function WinSSH
{
<#
.SYNOPSIS
    Run SSH commands from windows
.DESCRIPTION
    This will run commands to be run on VMware/vCenter hosts.
    This needs plink to be in the same folder as this script.
    This will open create a text file, you paste the commands which are to be run on the SSH target.        
.NOTES
    File Name      : WinSSH.ps1
    Author         : gajendra d ambi
    Date           : June 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/MrAmbiG/vmware
    http://www.virtu-al.net/2013/01/07/ssh-powershell-tricks-with-plink-exe/
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

#server's credentials
$user     = Read-Host "Host's username?"
$pass     = Read-Host "Host's password?"
$cluster  = Read-Host "name of the cluster[type * to include all clusters]?"
$VMHosts  = get-cluster $cluster | Get-VMHost | sort

#copy plink to c:\ for now
Copy-Item $PSScriptRoot\plink.exe C:\

$name     = "commands"
$commands = "$PSScriptRoot\$name.txt" #create text file
ni -ItemType file $commands -Force
ac $commands "#Paste your each command in a new line"
Start-Process $commands

$stopWatch = [system.diagnostics.stopwatch]::startNew() #timer start
$stopWatch.Start()

$lines = gc $commands

Copy-Item $PSScriptRoot\plink.exe C:\ #copy plink to c:\ for now

ForEach ($VMHost in $VMHosts)
    {
    Write-Host $vmhost.Name -ForegroundColor Black -BackgroundColor White
    Get-VMHost $VMHost | Get-VMHostService | where {$_.Key -eq "TSM-SSH"} | Start-VMHostService #start ssh    
    echo y | C:\plink.exe -ssh $user@$VMHost -pw $pass "exit" #store ssh keys    
    foreach ($line in $lines)
        {
        C:\plink.exe -ssh -v -noagent $VMHost -l $user -pw $pass "$line"
        }    
    Get-VMHost $VMHost | Get-VMHostService | where {$_.Key -eq "TSM-SSH"} | Stop-VMHostService #stop ssh
    }

$stopWatch.Stop()
Write-Host "Elapsed Runtime:" $stopWatch.Elapsed.Hours "Hours" $stopWatch.Elapsed.Minutes "minutes and" $stopWatch.Elapsed.Seconds "seconds." -BackgroundColor White -ForegroundColor Black
 #End of Script#
}#End of function