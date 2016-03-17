#start of function
function Setpcscd 
{
<#
.SYNOPSIS
    Configure pcscd [PC/SC Smart Card Daemon]
.DESCRIPTION
    Depending upon the choice that you make
    This will enable pcscd.
    This will disable pcscd.
    This will set pcscd policy to On which will be persistent across reboot.
    This will set pcscd policy to Off which will be persistent across reboot.
.NOTES
    File Name      : Setpcscd.ps1
    Author         : gajendra d ambi
    Date           : March 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#Start of script#
$cluster = Read-Host "name of the cluster[type * to include all clusters]?"
Write-Host "pcscd [PC/SC Smart Card Daemon] options
     1. Enable pcscd
     2. Disable pcscd
     3. pcscd Policy On
     4. pcscd Policy Off
     " -BackgroundColor White -ForegroundColor Blue #options to choose from
 $a = Read-Host "Choose a number from 1 to 4"
 if ($option -eq 1) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ pcscd | Start-VMHostService}
 if ($option -eq 2) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ pcscd | stop-VMHostService}
 if ($option -eq 3) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ pcscd | Set-VMHostService -Policy On}
 if ($option -eq 4) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ pcscd | Set-VMHostService -Policy Off}
    
 #End of Script#
}#End of function