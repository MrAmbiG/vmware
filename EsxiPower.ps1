 <#
.SYNOPSIS
    Gracefully reboot or poweroff the vmware hosts.
.DESCRIPTION
    This will offer you 3 options, reboot the hosts in maintenance mode, shutdown the hosts in maintenance mode
    or just exti or disconnect from the vcenter server. This search for the hosts in maintenance mode and
    perform the shutdown or reboot action based on your input. So this will work only on hosts in maintenance mode
 <#
.SYNOPSIS
    Gracefully reboot or poweroff the vmware hosts.
.DESCRIPTION
    This will offer you 3 options, reboot the hosts in maintenance mode, shutdown the hosts in maintenance mode
    or just exi or disconnect from the vcenter server. This search for the hosts in maintenance mode and
    performs the shutdown or reboot action based on your input. So this will work only on hosts in maintenance mode
    planned improvements:
    if the VM count is zero on hosts then put them in maintenance mode and perform the shutdown or reboot action.
.NOTES
    File Name      : EsxiPower.ps1
    Date           : 7/21/2015
    Author         : gajendra d ambi
    Prerequisite   : PowerShell V2+, powercli 5+ over Vista and upper.
    Copyright      - None
.LINK
    Script posted over:
    http://tinyurl.com/esxipower
    http://tinyurl.com/ambigitvmware
    http://tinyurl.com/fewliner
#>
#Start of Script
 
#If using in powershell then add snapins below
Add-PSSnapin VMware.VimAutomation.Core -ea "SilentlyContinue"

#disconnect from currently connected servers if any
disconnect-viserver *

#connect to the vcenter server
connect-viserver

#get the reason to shutdown or reboot these hosts
$user = Read-Host "ESXi host's username?"
$pass = Read-Host "ESXi host's password?"
$reason = Read-Host "Please enter the reason for this power action" 
$action = Read-Host "Type poweroff or reboot"

#list and connect to the hosts in maintenance mode
$VMHosts = Get-VMHost -state maintenance | sort
foreach ($VMHost in $VMHosts) {
Connect-VIServer $VMHost -User $user -Password $pass
}

#perform reboot or poweroff action on the above hosts
$esxcli = get-esxcli
$esxcli.system.shutdown.$action($null,"$reason")

#End of Script
#Shutdown hosts of a cluster without any reason via powercli directly from vCenter
#get-cluster $cluster | get-vmhost | stop-vmhost -confirm:$false
