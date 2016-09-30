<#
.SYNOPSIS
    Make hostfile entries to esxi hosts

.DESCRIPTION
    This will use plink to make entries to the host file of the esxi hosts.
    please have a copy of plink.exe in the folder where this script is located.

.NOTES
    File Name      : ESXihostfile.ps1
    Author         : gajendra d ambi
    Prerequisite   : PowerShell V3, powercli 5.x over Vista and upper.
    Copyright      - None

.LINK
    Script posted over:
    http://www.virtu-al.net/2013/01/07/ssh-powershell-tricks-with-plink-exe/
    https://github.com/gajuambi/vmware
#>
#Start of Script

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
    Date           : Audust 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
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

#Disconnect from already connected viservers if any
Disconnect-VIServer * -ErrorAction SilentlyContinue

#Connect to the vcenter server
connect-viserver

#X server's credentials
$user = Read-Host "Host's username?"
$pass = Read-Host "Host's password?"

#copy plink to c:\ for now
Copy-Item $PSScriptRoot\plink.exe C:\

#variables
#put the name of the cluster between quotes (replacing star). Enter multiple cluster names & separate them by a comma (no space in between)
$cluster = Read-Host "Name of the cluster?"
$VMHosts = get-cluster $cluster | Get-VMHost | sort

#Enable SSH on all hosts
get-cluster $cluster | Get-VMHost | Get-VMHostService | where {$_.Key -eq "TSM-SSH"} | Start-VMHostService

ForEach ($VMHost in $VMHosts)
{
echo y | C:\plink.exe -ssh $user@$VMHost -pw $pass "exit"

#replace the "someline" with the value that you want.
#To add multiple lines repeat the below command multiple times with the respective values instead of someline (enclose entries within "")
C:\plink.exe -ssh -v -noagent $VMHost -l $user -pw $pass 'echo "someline" >> /etc/hosts'

#This line below displays the resulting contents of the file
C:\plink.exe -ssh -v -noagent $VMHost -l $user -pw $pass "cat /etc/hosts"
}

#delete plink from c:\
Remove-Item C:\plink.exe

#Disable SSH on all hosts
get-cluster $cluster | Get-VMHost | Get-VMHostService | where {$_.Key -eq "TSM-SSH"} | Stop-VMHostService -confirm:$false

#End of Script
