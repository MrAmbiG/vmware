#start of function
function SetDCUI 
{
<#
.SYNOPSIS
    Configure DCUI [Direct Console UI]
.DESCRIPTION
    Depending upon the choice that you make
    This will enable DCUI.
    This will disable DCUI.
    This will set DCUI policy to On which will be persistent across reboot.
    This will set DCUI policy to Off which will be persistent across reboot.
.NOTES
    File Name      : SetDCUI.ps1
    Author         : gajendra d ambi
    Date           : March 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#Start of script#
$cluster = Read-Host "name of the cluster[type * to include all clusters]?"
Write-Host "DCUI [Direct Console UI] options
     1. Enable DCUI
     2. Disable DCUI
     3. DCUI Policy On
     4. DCUI Policy Off
     " -BackgroundColor White -ForegroundColor Blue #options to choose from
 $a = Read-Host "Choose a number from 1 to 4"
 if ($option -eq 1) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ DCUI | Start-VMHostService}
 if ($option -eq 2) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ DCUI | stop-VMHostService}
 if ($option -eq 3) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ DCUI | Set-VMHostService -Policy On}
 if ($option -eq 4) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ DCUI | Set-VMHostService -Policy Off}
    
 #End of Script#
}#End of function