#start of function
function Setlbtd
{
<#
.SYNOPSIS
    Configure lbtd[Load-Based Teaming Daemon]
.DESCRIPTION
    Depending upon the choice that you make
    This will enable lbtd.
    This will disable lbtd.
    This will set lbtdpolicy to On which will be persistent across reboot.
    This will set lbtdpolicy to Off which will be persistent across reboot.
.NOTES
    File Name      : SetLbtd.ps1
    Author         : gajendra d ambi
    Date           : March 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#Start of script#
$cluster = Read-Host "name of the cluster[type * to include all clusters]?"
Write-Host "lbtd[Load-Based Teaming Daemon] options
     1. Enable lbtd
     2. Disable lbtd
     3. lbtdPolicy On
     4. lbtdPolicy Off
     " -BackgroundColor White -ForegroundColor Blue #options to choose from
 $a = Read-Host "Choose a number from 1 to 4"
 if ($option -eq 1) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ lbtd| Start-VMHostService}
 if ($option -eq 2) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ lbtd| stop-VMHostService}
 if ($option -eq 3) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ lbtd| Set-VMHostService -Policy On}
 if ($option -eq 4) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ lbtd| Set-VMHostService -Policy Off}
    
 #End of Script#
}#End of function