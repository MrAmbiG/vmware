#Add powercli modules to the powershell if running in powershell
#Add-PSSnapin VMware.VimAutomation.Core
param(
$VMhost ="*"
)
$ManagementHost0 = Read-Host "Address of the ManagementHost0"
$ManagementHost1 = Read-Host "Address of the ManagementHost1"
$ManagementHost2 = Read-Host "Address of the ManagementHost2"
$ESXiUser = "root"
$ESXiPass = "VMwar3!!"

#$vmcount = Get-VMHost | get-vm | measure-object


$vmcount = get-vm | measure-object

#Enter maintenance mode
Get-VMHost | where {$vmcount -eq '0'} | Set-VMHost -State Maintenance
#shutdown hosts
Get-VMHost | where {$vmcount -eq '0'} | %{$_.ExtensionData.ShutdownHost_Task($TRUE)}

connect-viserver -VMHost $ManagementHost2 -User $ESXiUser -Password $ESXiPass

#VMs (windows) with vmware tools will be shutdown gracefully
#Get-VM | Shutdown-VMGuest -Confirm:$false
$vms = Get-VM
foreach($vm in $vms)
{
Shutdown-VMGuest $vm -Confirm:$false

Write-Host "$VM is stopping"
}

#Wait for 200 seconds for the VMs with VMware tools to shutdown
Start-Sleep -s 200

#Now stop the VMs with no vmware tools in them (gnu/linux based)
$vms = Get-VM
foreach($vm in $vms)
{
Get-VM $vm | where {$_.status -eq "powered on"}

Stop-VM $vm -Confirm:$false

Write-Host "$VM is stopping"
}

#Just in case if the above has not worked then we will force stop the gnu/linux based VMs
$vms = Get-VM
foreach($vm in $vms)
{
Get-VM $vm | where {$_.status -eq "powered on"}

Stop-VM $vm -kill -Confirm:$false

Write-Host "$VM is stopping"
}

#put the host in maintenance mode
Set-VMHost -State Maintenance

#shut down the host
%{$_.ExtensionData.ShutdownHost_Task($TRUE)}

connect-viserver -VMHost $ManagementHost1 -User $ESXiUser -Password $ESXiPass

#VMs (windows) with vmware tools will be shutdown gracefully
Get-VM | Shutdown-VMGuest -Confirm:$false

#Wait for 200 seconds for the VMs with VMware tools to shutdown
Start-Sleep -s 200

#Now stop the VMs with no vmware tools in them (gnu/linux based)
$vms = Get-VM
foreach($vm in $vms)
{
Get-VM $vm | where {$_.status -eq "powered on"}

Stop-VM $vm -Confirm:$false

Write-Host "$VM is stopping"
}

#Just in case if the above has not worked then we will force stop the gnu/linux based VMs
$vms = Get-VM
foreach($vm in $vms)
{
Get-VM $vm | where {$_.status -eq "powered on"}

Stop-VM $vm -kill -Confirm:$false

Write-Host "$VM is stopping"
}

#put the host in maintenance mode
Set-VMHost -State Maintenance

#shut down the host
%{$_.ExtensionData.ShutdownHost_Task($TRUE)}

connect-viserver -VMHost $ManagementHost0 -User $ESXiUser -Password $ESXiPass

#VMs (windows) with vmware tools will be shutdown gracefully
Get-VM | Shutdown-VMGuest -Confirm:$false

#Wait for 200 seconds for the VMs with VMware tools to shutdown
Start-Sleep -s 200

#Now stop the VMs with no vmware tools in them (gnu/linux based)
$vms = Get-VM
foreach($vm in $vms)
{
Get-VM $vm | where {$_.status -eq "powered on"}

Stop-VM $vm -Confirm:$false

Write-Host "$VM is stopping"
}

#Just in case if the above has not worked then we will force stop the gnu/linux based VMs
$vms = Get-VM
foreach($vm in $vms)
{
Get-VM $vm | where {$_.status -eq "powered on"}

Stop-VM $vm -kill -Confirm:$false

Write-Host "$VM is stopping"
}

#put the host in maintenance mode
Set-VMHost -State Maintenance

#shut down the host
%{$_.ExtensionData.ShutdownHost_Task($TRUE)}
