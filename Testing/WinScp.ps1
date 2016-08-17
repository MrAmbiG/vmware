function WinScp {
<#
.SYNOPSIS
    Upload files via scp
.DESCRIPTION
    This will upload files to the target via scp
.NOTES
    File Name      : WinScp.ps1
    Author         : gajendra d ambi
    updated        : August 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/mrambig/vmware
#>
##Start of the script##
Getpscp #custom function gets pscp.exe #https://github.com/MrAmbiG/vmware/blob/master/vTool/vToolMenus/MainMenu/vCenterMenu/HostMenu/Getpscp.ps1

#server's credentials
$user     = Read-Host "username?"
$pass     = Read-Host "password?"
$file     = Read-Host "filename.extention?"

Write-Host "
A text file will be opened (or open it with notepad)
populate the target host's ip or fqdn one below the other without any spaces,
save it and then hit enter/return in this console
" -ForegroundColor Black -BackgroundColor White

$name     = "targets"
$targets  = "$PSScriptRoot\$targets.txt" #create text file
ni -ItemType file $targets -Force

#copy pscp to c:\ for now
Copy-Item $PSScriptRoot\pscp.exe C:\

$stopWatch = [system.diagnostics.stopwatch]::startNew() #timer start
$stopWatch.Start()

ForEach ($target in $targets)
    {
    Write-Host $vmhost.Name -ForegroundColor Black -BackgroundColor White   
    #echo y | C:\pscp.exe -ssh $user@$VMHost -pw $pass "exit"
    C:\pscp.exe $file $user@$target":/tmp"
    }

$stopWatch.Stop()
Write-Host "Elapsed Runtime:" $stopWatch.Elapsed.Hours "Hours" $stopWatch.Elapsed.Minutes "minutes and" $stopWatch.Elapsed.Seconds "seconds." -BackgroundColor White -ForegroundColor Black
 #End of Script#
}#End of function