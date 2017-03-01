
<#
.SYNOPSIS
    Gets the plink
.DESCRIPTION
    This will create l3gateway to esxi hosts.
.NOTES
    File Name      : L3VmotionGateway.ps1
    Author         : gajendra d ambi
    Date           : March 2017
    Prerequisite   : PowerShell v4+, over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: 
    github.com/mrambig
    [source] http://www.virtu-al.net/2013/01/07/ssh-powershell-tricks-with-plink-exe/
#>
#Start of function
function GetPlink 
{
<#
.SYNOPSIS
    Gets the plink
.DESCRIPTION
    This will make sure plink is either downloaded from the internet if it is not present and if it cannot download
    then it will pause the script till you copy it manually.
.NOTES
    File Name      : GetPlink.ps1
    Author         : gajendra d ambi
    Date           : August 2016
    Prerequisite   : PowerShell v4+, over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: 
    github.com/mrambig
    [source] http://www.virtu-al.net/2013/01/07/ssh-powershell-tricks-with-plink-exe/

#>
$PlinkLocation = $PSScriptRoot + "\Plink.exe"
$presence = Test-Path $PlinkLocation
if (-not $presence) 
    {
    Write-Host "Missing Plink.exe, trying to download...(10 seconds)" -BackgroundColor White -ForegroundColor Black
    Invoke-RestMethod "http://the.earth.li/~sgtatham/putty/latest/x86/plink.exe" -TimeoutSec 10 -OutFile "plink.exe"
    if (-not $presence)
        {
            do
            {
            Write-Host "Unable to download plink.exe, please download and add it to the same folder as this script" -BackgroundColor Yellow -ForegroundColor Black
            Read-host "Hit Enter/Return once plink is present"
            $presence = Test-Path $PlinkLocation
            } while (-not $presence)
        }
    }

if ($presence) { Write-Host "Detected Plink.exe" -BackgroundColor White -ForegroundColor Black }
} #End of function

GetPlink
#If using in powershell then add snapins below for VMware ESXi.
Add-PSSnapin VMware.VimAutomation.Core -ErrorAction SilentlyContinue

#X server's credentials
$user = Read-Host "Host's username?"
$pass = Read-Host "Host's password?"
$l3gw = Read-Host "L3 vmotion Gateway to be added?"
$cluster = Read-Host "Name of the cluster?"
$VMHosts = get-cluster $cluster | get-vmhost
$command = "esxcfg-route -N vmotion -a default $l3gw"

#copy plink to c:\ for now
Copy-Item $PSScriptRoot\plink.exe C:\

ForEach ($VMHost in $VMHosts)
{
get-cluster $cluster | Get-VMHost $VMHost | Get-VMHostService | where {$_.Key -eq "TSM-SSH"} | Start-VMHostService #Enable SSH on all hosts
echo y | C:\plink.exe -ssh $user@$VMHost -pw $pass "exit"
C:\plink.exe -ssh -v -noagent $VMHost -l $user -pw $pass "hostname"
C:\plink.exe -ssh -v -noagent $VMHost -l $user -pw $pass $command #modify or duplicate only this line
get-cluster $cluster | Get-VMHost $VMHost | Get-VMHostService | where {$_.Key -eq "TSM-SSH"} | Stop-VMHostService -confirm:$false #Disable SSH on all hosts
}

write-host "Reboot hosts (vtool->host>power options) to make sure the changes are visible" -ForegroundColor yellow
