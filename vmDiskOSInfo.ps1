<#
.SYNOPSIS
    Get linux vms and their disk info
.DESCRIPTION
    Gets the VMs and filters them by linux OS, get their disk count and their sizes.    
.NOTES
    File Name      : vmDiskOSInfo.ps1
    Author         : gajendra d ambi
    Date           : April 2017
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/MrAmbiG/vmware
#>
$vms = get-vm | where { $_.ExtensionData.Guest.GuestFamily -match 'linuxGuest' }
$system = New-Object -TypeName PSObject
foreach ($vm in $vms)
{
New-Object PSObject -Property @{
            'VM Name' = $vm.name
            'OS' = $vm.Guest.OSFullName
            'DiskCount' = ($vm | Get-HardDisk).count
            'DiskSizes' = ($vm | Get-HardDisk).CapacityGB -join ';'
             }
}
