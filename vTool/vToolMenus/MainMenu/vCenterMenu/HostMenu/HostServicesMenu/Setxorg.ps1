#start of function
function Setxorg 
{
<#
.SYNOPSIS
    Configure xorg [X.Org Server]
.DESCRIPTION
    Depending upon the choice that you make
    This will enable xorg.
    This will disable xorg.
    This will set xorg policy to On which will be persistent across reboot.
    This will set xorg policy to Off which will be persistent across reboot.
.NOTES
    File Name      : Setxorg.ps1
    Author         : gajendra d ambi
    Date           : March 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#Start of script#
$cluster = Read-Host "name of the cluster[type * to include all clusters]?"
Write-Host "xorg [X.Org Server] options
     1. Enable xorg
     2. Disable xorg
     3. xorg Policy On
     4. xorg Policy Off
     " -BackgroundColor White -ForegroundColor Blue #options to choose from
 $a = Read-Host "Choose a number from 1 to 4"
 if ($option -eq 1) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ xorg | Start-VMHostService}
 if ($option -eq 2) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ xorg | stop-VMHostService}
 if ($option -eq 3) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ xorg | Set-VMHostService -Policy On}
 if ($option -eq 4) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ xorg | Set-VMHostService -Policy Off}
    
 #End of Script#
}#End of function