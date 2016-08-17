#Start of function
function GetPscp 
{
<#
.SYNOPSIS
    Gets the Pscp

.DESCRIPTION
    This will make sure Pscp is either downloaded from the internet if it is not present and if it cannot download
    then it will pause the script till you copy it manually.

.NOTES
    File Name      : GetPscp.ps1
    Author         : gajendra d ambi
    Date           : August 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None

.LINK
    Script posted over: 
    github.com/mrambig
#>
$PscpLocation = $PSScriptRoot + "\Pscp.exe"
$presence = Test-Path $PscpLocation
if (-not $presence) 
    {
    Write-Host "Missing Pscp.exe, trying to download...(10 seconds)" -BackgroundColor White -ForegroundColor Black
    Invoke-RestMethod "http://the.earth.li/~sgtatham/putty/latest/x86/Pscp.exe" -TimeoutSec 10 -OutFile "Pscp.exe"
    if (-not $presence)
        {
            do
            {
            Write-Host "Unable to download Pscp.exe, please download and add it to the same folder as this script" -BackgroundColor Yellow -ForegroundColor Black
            Read-host "Hit Enter/Return once Pscp is present"
            $presence = Test-Path $PscpLocation
            } while (-not $presence)
        }
    }

if ($presence) { Write-Host "Detected Pscp.exe" -BackgroundColor White -ForegroundColor Black }
} #End of function