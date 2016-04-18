#start of function
function SetSSH 
{
<#
.SYNOPSIS
    Configure TSM-SSH [SSH]
.DESCRIPTION
    Depending upon the choice that you make
    This will enable TSM-SSH.
    This will disable TSM-SSH.
    This will set TSM-SSH policy to On which will be persistent across reboot.
    This will set TSM-SSH policy to Off which will be persistent across reboot.
.NOTES
    File Name      : SetSSH.ps1
    Author         : gajendra d ambi
    Date           : March 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#Start of script#
$cluster = Read-Host "name of the cluster[type * to include all clusters]?"
Write-Host "TSM-SSH [SSH] options
     1. Enable TSM-SSH
     2. Disable TSM-SSH
     3. TSM-SSH Policy On
     4. TSM-SSH Policy Off
     " -BackgroundColor White -ForegroundColor Blue #options to choose from
 $a = Read-Host "Choose a number from 1 to 4"
 if ($a -eq 1) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ TSM-SSH | Start-VMHostService -Confirm:$false}
 if ($a -eq 2) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ TSM-SSH | stop-VMHostService -Confirm:$false}
 if ($a -eq 3) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ TSM-SSH | Set-VMHostService -Policy On -Confirm:$false}
 if ($a -eq 4) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ TSM-SSH | Set-VMHostService -Policy Off -Confirm:$false}
    
 #End of Script#
}#End of function