<#
.SYNOPSIS
    Configure VM security hardening for your VMs
.DESCRIPTION
    Thanks to andrew for the idea of creating a VM spec and pushing it to all the VMs. This
    will create a VM spec using some security hardening best practices but it will apply only to the windows guest VMs.
.NOTES
    File Name      : VMSecurityHardening.ps1
    Author         : andrew > gajendra d ambi
    Prerequisite   : Powercli 5.x, PowerShell V2 over Vista and upper.
    Copyright      - None
.LINK
    Script posted over:
    concept : http://practical-admin.com/blog/powercli-update-vmx-configuration-parameters-in-mass/
    adaptation : http://tinyurl.com/ambigitvmware
    http://www.stigviewer.com/stig/vmware_esxi_version_5_virtual_machine/2013-12-18/
#>

#Disconnect any other hosts or vcenters if they are already connected.
#Write-Host "Let us disconnect any other ESXi hosts or vcenters if they are connected"
##Disconnect-VIServer *

#connect to the host or vcenter server
#Write-Host "Let us connect to the target host or vCenter"
#connect-viserver

#start VMSecurity function
Function Fun_VMSecurity {
$ExtraOptions = @{
#http://practical-admin.com/blog/powercli-update-vmx-configuration-parameters-in-mass/ 
    "isolation.tools.diskWiper.disable"="true";
    "isolation.tools.diskShrink.disable"="true";
	"RemoteDisplay.maxConnections"="1";
	"isolation.tools.copy.disable"="true";
	"isolation.tools.paste.disable"="true";
	"isolation.tools.setGUIOptions.enable"="false";
	"isolation.tools.dnd.disable"="true";
	"isolation.device.connectable.disable"="true";
	"isolation.device.edit.disable"="true";
	"vmci0.unrestricted"="false";
	"log.rotateSize"="1000000";
	"log.keepOld"="10";
	"tools.setInfo.sizeLimit"="1048576";
	"guest.command.enabled"="false";
	"tools.guestlib.enableHostInfo"="false";
	"isolation.tools.unity.push.update.disable"="true";
	"isolation.tools.ghi.launchmenu.change"="true";
	"isolation.tools.memSchedFakeSampleStats.disable"="true";
	"isolation.tools.getCreds.disable"="true";
	"floppyX.present"="false";
	"SerialX.present"="false";
	"parallelX.present"="false";
	"usb.present"="false";
	"ideX:Y.present"="false";
}
 
# build our configspec using the hashtable from above.
$vmConfigSpec = New-Object VMware.Vim.VirtualMachineConfigSpec
# note we have to call the GetEnumerator before we can iterate through
Foreach ($Option in $ExtraOptions.GetEnumerator()) {
    $OptionValue = New-Object VMware.Vim.optionvalue
    $OptionValue.Key = $Option.Key
    $OptionValue.Value = $Option.Value
    $vmConfigSpec.extraconfig += $OptionValue
}

# Get all vm's
Write-Host "choose wisely :)
Apply vm security hardening to
1. windows VMs
2. Gnu/Linux VMs
3. All VMs
" -BackgroundColor White -ForegroundColor Black
$option = Read-Host "choose a number from above?"

if ($option -eq "1") { $VMs = Get-View -ViewType VirtualMachine -Property Name -Filter @{"Guest.Guestfamily"="WindowsGuest"} }
if ($option -eq "2") { $VMs = Get-View -ViewType VirtualMachine -Property Name -Filter @{"Guest.Guestfamily"="linuxGuest"} }
if ($option -eq "3") { $VMs = Get-View -ViewType VirtualMachine -Property Name }

Write-Host "The following will be applied with a security hardening spec" -BackgroundColor White -ForegroundColor Black
$VMs.Name
 
# Apply the new virtual machine spec with security hardening parameters
foreach($vm in $vms){
    $vm.ReconfigVM_Task($vmConfigSpec)
    Write-Host "Security hardening for $VM is complete"
}
} #End VMSecurity function
Fun_VMSecurity

