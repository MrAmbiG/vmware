#start of function
function Setvpxa 
{
<#
.SYNOPSIS
    Configure vpxa [VMware vCenter Agent]
.DESCRIPTION
    Depending upon the choice that you make
    This will enable vpxa.
    This will disable vpxa.
    This will set vpxa policy to On which will be persistent across reboot.
    This will set vpxa policy to Off which will be persistent across reboot.
.NOTES
    File Name      : Setvpxa.ps1
    Author         : gajendra d ambi
    Date           : March 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#Start of script#
$cluster = Read-Host "name of the cluster[type * to include all clusters]?"
Write-Host "vpxa [VMware vCenter Agent] options
     1. Enable vpxa
     2. Disable vpxa
     3. vpxa Policy On
     4. vpxa Policy Off
     " -BackgroundColor White -ForegroundColor Blue #options to choose from
 $a = Read-Host "Choose a number from 1 to 4"
 if ($option -eq 1) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ vpxa | Start-VMHostService}
 if ($option -eq 2) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ vpxa | stop-VMHostService}
 if ($option -eq 3) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ vpxa | Set-VMHostService -Policy On}
 if ($option -eq 4) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ vpxa | Set-VMHostService -Policy Off}
    
 #End of Script#
}#End of function