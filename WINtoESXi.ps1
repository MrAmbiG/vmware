<#
.SYNOPSIS
    Run any ssh commands via powershell, powercli

.DESCRIPTION
    This will run any scripts on the target vmware host with ssh enabled in it.
    find the below line
    C:\plink.exe -ssh -v -noagent $VMHost -l $user -pw $pass 'command1'
    and replace command1 with your actuall command to run on the x server. If you are willing to modify it a bit
    it can be used against any nix (linux/unix like) hosts to.

.EXAMPLE
   C:\plink.exe -ssh -v -noagent $VMHost -l $user -pw $pass 'echo "something" >> /etc/hosts'
   the above will add the word something to /etc/hosts
   C:\plink.exe -ssh -v -noagent $VMHost -l $user -pw $pass 'reboot'
   the above will reboot the target server
   you can put multiple such lines one below the other. as many as you want.

.NOTES
    File Name      : WINtoESXi.ps1
    Author         : gajendra d ambi
    Prerequisite   : PowerShell V3, powercli 5.x over Vista and upper.
    Copyright      - None

.LINK
    Script posted over:
    http://www.virtu-al.net/2013/01/07/ssh-powershell-tricks-with-plink-exe/
    https://github.com/gajuambi/vmware
#>

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
$cluster = "*"
$VMHosts = get-cluster $cluster | Get-VMHost | sort

ForEach ($VMHost in $VMHosts)
{
#Enable SSH on all hosts
get-cluster $cluster | Get-VMHost $VMHost | Get-VMHostService | where {$_.Key -eq "TSM-SSH"} | Start-VMHostService

echo y | C:\plink.exe -ssh $user@$VMHost -pw $pass "exit"

#replace the "someline" with the value that you want.
#To add multiple lines repeat the below command multiple times with the respective values instead of someline (enclose entries within "")
C:\plink.exe -ssh -v -noagent $VMHost -l $user -pw $pass 'command1'

#do not modify the below line
C:\plink.exe -ssh -v -noagent $VMHost -l $user -pw $pass "hostname"

#Disable SSH on all hosts
get-cluster $cluster | Get-VMHost $VMHost | Get-VMHostService | where {$_.Key -eq "TSM-SSH"} | Stop-VMHostService -confirm:$false
}

#delete plink from c:\
Remove-Item C:\plink.exe

#End of Script
