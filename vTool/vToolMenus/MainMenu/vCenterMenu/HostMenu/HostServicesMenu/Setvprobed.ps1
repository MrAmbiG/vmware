#start of function
function Setvprobed 
{
<#
.SYNOPSIS
    Configure vprobed [VProbe Daemon]
.DESCRIPTION
    Depending upon the choice that you make
    This will enable vprobed.
    This will disable vprobed.
    This will set vprobed policy to On which will be persistent across reboot.
    This will set vprobed policy to Off which will be persistent across reboot.
.NOTES
    File Name      : Setvprobed.ps1
    Author         : gajendra d ambi
    Date           : March 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#Start of script#
$cluster = Read-Host "name of the cluster[type * to include all clusters]?"
Write-Host "vprobed [VProbe Daemon] options
     1. Enable vprobed
     2. Disable vprobed
     3. vprobed Policy On
     4. vprobed Policy Off
     " -BackgroundColor White -ForegroundColor Blue #options to choose from
 $a = Read-Host "Choose a number from 1 to 4"
 if ($option -eq 1) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ vprobed | Start-VMHostService}
 if ($option -eq 2) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ vprobed | stop-VMHostService}
 if ($option -eq 3) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ vprobed | Set-VMHostService -Policy On}
 if ($option -eq 4) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ vprobed | Set-VMHostService -Policy Off}
    
 #End of Script#
}#End of function