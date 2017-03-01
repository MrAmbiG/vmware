<#
.SYNOPSIS
    It will change the VM's hardware resources and set the annotations.
.DESCRIPTION
    This requires you to provide the target vm names to apply the settings.
    check the variables section to update the values.
.NOTES
    File Name      : VMsettings.ps1
    Author         : gajendra d ambi
    Date           : August 2015
    Prerequisite   : PowerShell V2 over Vista and upper.
    Copyright      - None
.LINK
    Script posted over: https://github.com/gajuambi/vmware
    
#>

#Fill these details
$vc = ""
$db = ""
$um = ""

#annotations
$vc_annotation = "vcenter"
$db_annotation = "Database Server"
$um_annotation = "update Manager"

#If using in powershell then add snapins below
Add-PSSnapin VMware.VimAutomation.Core -ErrorAction SilentlyContinue

#Disconnect from already connected viservers if any
Disconnect-VIServer * -ErrorAction SilentlyContinue

#Get host's details
$host = Read-Host "address of the esxi host on which the VMs are deployed?"
$user = "root"
$pass = Read-Host "Password for the esxi host?"
Connect-VIServer $host -User $user -Password $pass

#vCenter Server
#change memory and cpu
get-vm $vc | Set-VM -NumCpu 6 -MemoryGB 20 -Confirm:$false
#grow the 1st 2 harddisks
(Get-HardDisk -vm $vc)[0] | Set-HardDisk -CapacityGB 60 -Confirm:$false
(Get-HardDisk -vm $vc)[1] | Set-HardDisk -CapacityGB 40 -Confirm:$false
#add 2 additional hard disks and provision them as thin
New-HardDisk -vm $vc -CapacityGB 40 -StorageFormat Thin -Confirm:$false
New-HardDisk -vm $vc -CapacityGB 40 -StorageFormat Thin -Confirm:$false
#set annotation
set-vm -vm $vc -Notes "$vc_annotation" -confirm:$false
Write-host ""

#database server
#change memory and cpu
get-vm $db | Set-VM -NumCpu 4 -MemoryGB 16 -Confirm:$false
#grow harddisks
(Get-HardDisk -vm $db)[0] | Set-HardDisk -CapacityGB 60 -Confirm:$false
(Get-HardDisk -vm $db)[1] | Set-HardDisk -CapacityGB 60 -Confirm:$false
(Get-HardDisk -vm $db)[2] | Set-HardDisk -CapacityGB 60 -Confirm:$false
(Get-HardDisk -vm $db)[3] | Set-HardDisk -CapacityGB 60 -Confirm:$false
#set annotation
set-vm -vm $db -Notes "$db_annotation" -confirm:$false
Write-host ""

#update manager
#change memory and cpu
get-vm $um | Set-VM -NumCpu 4 -MemoryGB 8 -Confirm:$false
#grow harddisks
(Get-HardDisk -vm $um)[0] | Set-HardDisk -CapacityGB 50 -Confirm:$false
(Get-HardDisk -vm $um)[1] | Set-HardDisk -CapacityGB 50 -Confirm:$false
#set annotation
set-vm -vm $um -Notes "$um_annotation" -confirm:$false
Write-host ""
