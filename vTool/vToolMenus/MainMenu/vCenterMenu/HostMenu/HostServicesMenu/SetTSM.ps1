#start of function
function SetTSM 
{
<#
.SYNOPSIS
    Configure TSM [ESXi Shell]
.DESCRIPTION
    Depending upon the choice that you make
    This will enable TSM.
    This will disable TSM.
    This will set TSM policy to On which will be persistent across reboot.
    This will set TSM policy to Off which will be persistent across reboot.
.NOTES
    File Name      : SetTSM.ps1
    Author         : gajendra d ambi
    Date           : March 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#Start of script#
$cluster = Read-Host "name of the cluster[type * to include all clusters]?"
Write-Host "TSM [ESXi Shell] options
     1. Enable TSM
     2. Disable TSM
     3. TSM Policy On
     4. TSM Policy Off
     " -BackgroundColor White -ForegroundColor Blue #options to choose from
 $a = Read-Host "Choose a number from 1 to 4"
 if ($option -eq 1) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ TSM | Start-VMHostService}
 if ($option -eq 2) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ TSM | stop-VMHostService}
 if ($option -eq 3) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ TSM | Set-VMHostService -Policy On}
 if ($option -eq 4) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ TSM | Set-VMHostService -Policy Off}
    
 #End of Script#
}#End of function