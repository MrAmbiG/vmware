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
GetPlink #custom function gets plink.exe #https://github.com/MrAmbiG/vmware/blob/master/vTool/vToolMenus/MainMenu/vCenterMenu/HostMenu/GetPlink.ps1

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
ac $commands "#Paste your each command in a new line which you want to run on each host"
Start-Process $commands

Read-Host "
copy all the ssh commands to the text file(enclose each command with single quotes in a new line),
save it
Hit enter/return to proceed further
"
$stopWatch = [system.diagnostics.stopwatch]::startNew() #timer start
$stopWatch.Start()

Copy-Item $PSScriptRoot\plink.exe C:\ #copy plink to c:\ for now

ForEach ($VMHost in $VMHosts)
    {
    Write-Host $vmhost.Name -ForegroundColor Black -BackgroundColor White
    Get-VMHost $VMHost | Get-VMHostService | where {$_.Key -eq "TSM-SSH"} | Start-VMHostService -confirm:$false #start ssh    
    echo y | C:\plink.exe -ssh $user@$VMHost -pw $pass "exit" #store ssh keys
    C:\plink.exe -ssh -v -noagent $VMHost -l $user -pw $pass -m $commands
    Get-VMHost $VMHost | Get-VMHostService | where {$_.Key -eq "TSM-SSH"} | Stop-VMHostService -confirm:$false #stop ssh
    }

$stopWatch.Stop()
Write-Host "Elapsed Runtime:" $stopWatch.Elapsed.Hours "Hours" $stopWatch.Elapsed.Minutes "minutes and" $stopWatch.Elapsed.Seconds "seconds." -BackgroundColor White -ForegroundColor Black
 #End of Script#
}#End of function
WinSSH