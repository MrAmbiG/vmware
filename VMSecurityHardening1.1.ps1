    <#
.SYNOPSIS
    Configure VM security hardening for your VMs
.DESCRIPTION
    Thanks to andrew for the idea of creating a VM spec and pushing it to all the VMs. This
    will create a VM spec using some security hardening best practices.
.NOTES
    File Name      : VMSecurityHardening1.1.ps1
    Author         : andrew > gajendra d ambi
    Prerequisite   : Powercli 5.x, PowerShell V2 over Vista and upper.
    Copyright      - None
.LINK
    Script posted over:
    concept : http://practical-admin.com/blog/powercli-update-vmx-configuration-parameters-in-mass/
    adaptation : http://tinyurl.com/ambigitvmware
    http://www.stigviewer.com/stig/vmware_esxi_version_5_virtual_machine/2013-12-18/
#>
    
$cluster = "*" #leave this value as it is if you want to include all clusters OR replace the * with the cluster's name to include all VMs of that cluster
$vmhost  = "*" #leave this value as it is if you want to include all hosts OR replace the * with the esxi hostname to include all VMs of that esxi host
$vm      = "*" #leave this value as it is if you want to include all VMs OR replace the * with the name of the VM to apply it to just one VM
Get-Cluster $cluster | Get-VMhost $vmhost | Get-VM $vm | Get-AdvancedSetting -Name "isolation.tools.diskWiper.disable" | Set-AdvancedSetting -Value "true"
Get-Cluster $cluster | Get-VMhost $vmhost | Get-VM $vm | Get-AdvancedSetting -Name "isolation.tools.diskShrink.disable" | Set-AdvancedSetting -Value "true"
Get-Cluster $cluster | Get-VMhost $vmhost | Get-VM $vm | Get-AdvancedSetting -Name "RemoteDisplay.maxConnections" | Set-AdvancedSetting -Value "1"
Get-Cluster $cluster | Get-VMhost $vmhost | Get-VM $vm | Get-AdvancedSetting -Name "isolation.tools.copy.disable" | Set-AdvancedSetting -Value "true"
Get-Cluster $cluster | Get-VMhost $vmhost | Get-VM $vm | Get-AdvancedSetting -Name "isolation.tools.paste.disable" | Set-AdvancedSetting -Value "true"
Get-Cluster $cluster | Get-VMhost $vmhost | Get-VM $vm | Get-AdvancedSetting -Name "isolation.tools.setGUIOptions.enable" | Set-AdvancedSetting -Value "false"
Get-Cluster $cluster | Get-VMhost $vmhost | Get-VM $vm | Get-AdvancedSetting -Name "isolation.tools.dnd.disable" | Set-AdvancedSetting -Value "true"
Get-Cluster $cluster | Get-VMhost $vmhost | Get-VM $vm | Get-AdvancedSetting -Name "isolation.device.connectable.disable" | Set-AdvancedSetting -Value "true"
Get-Cluster $cluster | Get-VMhost $vmhost | Get-VM $vm | Get-AdvancedSetting -Name "isolation.device.edit.disable" | Set-AdvancedSetting -Value "true"
Get-Cluster $cluster | Get-VMhost $vmhost | Get-VM $vm | Get-AdvancedSetting -Name "vmci0.unrestricted" | Set-AdvancedSetting -Value "false"
Get-Cluster $cluster | Get-VMhost $vmhost | Get-VM $vm | Get-AdvancedSetting -Name "log.rotateSize" | Set-AdvancedSetting -Value "1000000"
Get-Cluster $cluster | Get-VMhost $vmhost | Get-VM $vm | Get-AdvancedSetting -Name "log.keepOld" | Set-AdvancedSetting -Value "10"
Get-Cluster $cluster | Get-VMhost $vmhost | Get-VM $vm | Get-AdvancedSetting -Name "tools.setInfo.sizeLimit" | Set-AdvancedSetting -Value "1048576"
Get-Cluster $cluster | Get-VMhost $vmhost | Get-VM $vm | Get-AdvancedSetting -Name "guest.command.enabled" | Set-AdvancedSetting -Value "false"
Get-Cluster $cluster | Get-VMhost $vmhost | Get-VM $vm | Get-AdvancedSetting -Name "tools.guestlib.enableHostInfo" | Set-AdvancedSetting -Value "false"
Get-Cluster $cluster | Get-VMhost $vmhost | Get-VM $vm | Get-AdvancedSetting -Name "isolation.tools.unity.push.update.disable" | Set-AdvancedSetting -Value "true"
Get-Cluster $cluster | Get-VMhost $vmhost | Get-VM $vm | Get-AdvancedSetting -Name "isolation.tools.ghi.launchmenu.change" | Set-AdvancedSetting -Value "true"
Get-Cluster $cluster | Get-VMhost $vmhost | Get-VM $vm | Get-AdvancedSetting -Name "isolation.tools.memSchedFakeSampleStats.disable" | Set-AdvancedSetting -Value "true"
Get-Cluster $cluster | Get-VMhost $vmhost | Get-VM $vm | Get-AdvancedSetting -Name "isolation.tools.getCreds.disable" | Set-AdvancedSetting -Value "true"
Get-Cluster $cluster | Get-VMhost $vmhost | Get-VM $vm | Get-AdvancedSetting -Name "floppyX.present" | Set-AdvancedSetting -Value "false"
Get-Cluster $cluster | Get-VMhost $vmhost | Get-VM $vm | Get-AdvancedSetting -Name "SerialX.present" | Set-AdvancedSetting -Value "false"
Get-Cluster $cluster | Get-VMhost $vmhost | Get-VM $vm | Get-AdvancedSetting -Name "parallelX.present" | Set-AdvancedSetting -Value "false"
Get-Cluster $cluster | Get-VMhost $vmhost | Get-VM $vm | Get-AdvancedSetting -Name "usb.present" | Set-AdvancedSetting -Value "false"
Get-Cluster $cluster | Get-VMhost $vmhost | Get-VM $vm | Get-AdvancedSetting -Name "ideX:Y.present" | Set-AdvancedSetting -Value "false"
