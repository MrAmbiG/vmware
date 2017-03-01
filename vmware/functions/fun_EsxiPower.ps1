 <#
.SYNOPSIS
    Gracefully reboot or poweroff the vmware hosts.
.DESCRIPTION
    This will offer you 3 options, reboot the hosts in maintenance mode, shutdown the hosts in maintenance mode
    or just exi or disconnect from the vcenter server. This search for the hosts in maintenance mode and
    performs the shutdown or reboot action based on your input. So this will work only on hosts in maintenance mode       
.NOTES
    File Name      : fun_EsxiPower.ps1
    Date           : 7/21/2015
    Author         : gajendra d ambi
    Prerequisite   : PowerShell V3+, powercli 5+ over Vista and upper.
    Copyright      - None
.LINK
    Script posted over:   
    https://github.com/gajuambi/vmware/tree/master/vTool/functions
    https://github.com/gajuambi/vmware
    https://github.com/gajuambi
#>
#Start of Script

function fun_EsxiPower {
#get the reason to shutdown or reboot these hosts
$user    = Read-Host "ESXi host's username?"
$pass    = Read-Host "ESXi host's password?"
$cluster = "*"

Write-Host "
1 Enter Maintenance Mode
2 Exit Maintenance Mode
3 Shutdown
4 Reboot
" -ForegroundColor Yellow
Write-Host "choose between 1 to 4" -ForegroundColor Yellow
$option  = Read-Host ""
$vmhosts = get-cluster $cluster | get-vmhost
if ($option -eq 1) {$vmhosts | set-vmhost -State Maintenance}
if ($option -eq 2) {$vmhosts | set-vmhost -State Connected}
$vmhosts = get-cluster $cluster | get-vmhost -State Maintenance
if ($option -eq 3) {Write-Host "enter a reason for this action" -ForegroundColor Yellow
  $reason = Read-Host ""
  foreach ($vmhost in $vmhosts) {
  $esxcli = get-esxcli
  $esxcli.system.shutdown.poweroff($null,$reason)
  }
 }
if ($option -eq 4) {Write-Host "enter a reason for this action" -ForegroundColor Yellow
  $reason = Read-Host ""
  foreach ($vmhost in $vmhosts) {
  $esxcli = get-esxcli
  $esxcli.system.shutdown.reboot($null,$reason)
  }
 }
}
