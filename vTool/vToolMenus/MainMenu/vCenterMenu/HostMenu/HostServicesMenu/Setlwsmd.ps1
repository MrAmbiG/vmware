#start of function
function Setlwsmd 
{
<#
.SYNOPSIS
    Configure lwsmd [Active Directory Service]
.DESCRIPTION
    Depending upon the choice that you make
    This will enable lwsmd.
    This will disable lwsmd.
    This will set lwsmd policy to On which will be persistent across reboot.
    This will set lwsmd policy to Off which will be persistent across reboot.
.NOTES
    File Name      : Setlwsmd.ps1
    Author         : gajendra d ambi
    Date           : March 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#Start of script#
$cluster = Read-Host "name of the cluster[type * to include all clusters]?"
Write-Host "lwsmd [Active Directory Service] options
     1. Enable lwsmd
     2. Disable lwsmd
     3. lwsmd Policy On
     4. lwsmd Policy Off
     " -BackgroundColor White -ForegroundColor Blue #options to choose from
 $a = Read-Host "Choose a number from 1 to 4"
 if ($a -eq 1) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ lwsmd | Start-VMHostService -Confirm:$false}
 if ($a -eq 2) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ lwsmd | stop-VMHostService -Confirm:$false}
 if ($a -eq 3) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ lwsmd | Set-VMHostService -Policy On -Confirm:$false}
 if ($a -eq 4) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ lwsmd | Set-VMHostService -Policy Off -Confirm:$false}
    
 #End of Script#
}#End of function