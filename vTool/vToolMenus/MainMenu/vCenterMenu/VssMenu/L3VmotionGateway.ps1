#Start of function L3VmotionGateway
function L3VmotionGateway
{
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
#>
#Start of function
GetPlink
#If using in powershell then add snapins below for VMware ESXi.
Add-PSSnapin VMware.VimAutomation.Core -ErrorAction SilentlyContinue

Write-Host "This will only work if you can dns resolve hostnames from this machine"

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
} #End of function L3VmotionGateway