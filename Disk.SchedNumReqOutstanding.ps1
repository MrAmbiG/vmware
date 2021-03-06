
<#
.SYNOPSIS
    set and test the Disk.SchedNumReqOutstanding of xtremIO to 256
.DESCRIPTION
    Disk.SchedNumReqOutstanding is the maximum number of I/Os one VM can issue all the way down to the LUN
    when there is more than one VM pushing I/O to the same LUN.
    Please neglect any errors while you are run this if the script is not exiting abruptly after the error
.NOTES
    File Name      : Disk.SchedNumReqOutstanding.ps1
    Author         : davidring
    Prerequisite   : PowerCli 5.x over Vista and upper.
    Copyright      - 
.LINK
    Script posted over:
    http://davidring.ie/2014/09/08/emc-xtremio-setting-disk-schednumreqoutstanding-on-vsphere-5-5-powercli/

#>
#set Disk.SchedNumReqOutstanding of xtremIO to 256
#esxcli storage core device set -d naa.xxx -O "256"

$VMHosts = get-vmhost
foreach ($VMHost in $VMHosts)
{
Write-Host "setting values for $VMHost"
$esxcli = get-vmhost $VMHost | Get-EsxCli
$devices = $esxcli.storage.core.device.list()
foreach ($device in $devices)
{
if ($device.Model -like "XtremApp")
{
$esxcli.storage.core.device.set($null, $device.Device, $null, $null, $null, $null, $null, 256, $null)
}
}
}

