<#
.SYNOPSIS
   This will set the VM startup order, time delay etc., for VMs.
.DESCRIPTION
   This script will first disconnect from any existing vCenters which your open powercli might have already connected to(for safety).
   enable VM startup policy on the targetted hosts of the cluster.
   The script marked between the ####Main#### should be repeated for multiple groups of VMs or startup orders
   but yes, you have to change the integer of the variables to differentiate between others above it.
.NOTES
    File Name      : VMstartup.ps1
    Author         : gajendra d ambi
    Date           : Auguest 2015
    Prerequisite   : PowerShell V3, powercli 5+ over Vista and upper.
    Copyright      - None
.LINK
    Script posted over: ambitech.blogspot.in
    
#>

#Start of Script

#plugin vmware commands to powershell if running in powershell
Add-PSSnapin VMware.VimAutomation.Core -ea "SilentlyContinue"

#Disconnect from any existing or already connected vCenter server if any.
Disconnect-VIServer -Confirm:$false

#connect to the vcenter server
$vc = Read-Host "Target vCenter server?"
Connect-VIServer $vc

#replace the * with the name of the cluster if you so desire
$cluster = "*"
$VMhosts = get-cluster $cluster | get-vmhost

##Enable VM Startup policy on the above ESXi hosts
foreach($VMHost in $VMHosts){Set-VMHostStartPolicy -VMHostStartPolicy $VMHost -Enabled:$true}

####Main####
#name of VMs as registered in the vcenter which should be in the order1.
#separate multiple VMs by a comma but they should not be on the same host.
$group1 = ""
#the startup delay for the VMs in group1
$startdelay1 = ""
#the shutdown delay for the VMs in the group1
$shutdelay1 = ""

#order in which the VM should start
$order1 = ""

#set VM startup policy for group1
foreach ($vm in $group1) {Set-VMStartPolicy -StartPolicy (Get-VMStartPolicy -VM $vm) `
        -StartAction PowerOn -StartOrder $order1 -StartDelay $startdelay1 -StartOrder $shutdelay1
        }
####Main####

####Main####
#name of VMs as registered in the vcenter which should be in the order1.
#separate multiple VMs by a comma but they should not be on the same host.
$group2 = ""
#the startup delay for the VMs in group1
$startdelay2 = ""
#the shutdown delay for the VMs in the group1
$shutdelay2 = ""

#order in which the VM should start
$order2 = ""

#set VM startup policy for group1
foreach ($vm in $group2) {Set-VMStartPolicy -StartPolicy (Get-VMStartPolicy -VM $vm) `
        -StartAction PowerOn -StartOrder $order2 -StartDelay $startdelay2 -StartOrder $shutdelay2
        }
####Main####

#Disconnect from the vcenter server
Disconnect-VIServer -Confirm:$false

#End of Script
