
<#
.SYNOPSIS
    set and test the XioSettings to 256
.DESCRIPTION
    Disk.SchedNumReqOutstanding is the maximum number of I/Os one VM can issue all the way down to the LUN
    when there is more than one VM pushing I/O to the same LUN.
    Please neglect any errors while you are run this if the script is not exiting abruptly after the error
.NOTES
    File Name      : XioSetting.ps1
    Author         : Gajendra D Ambi
    Prerequisite   : PowerCli 5.x over Vista and upper.
    Copyright      - 
.LINK
    Script posted over:
    https://github.com/gajuambi/vmware/

#>
#set Disk.SchedNumReqOutstanding of xtremIO to 256
#esxcli storage core device set -d naa.xxx -O "256"

foreach ($VMHost in $(get-vmhost | sort))
{
$xappluns = (get-vmhost $VMHost | Get-EsxCli).storage.core.device.list() | where vendor -eq "XtremIO"
foreach ($xapplun in $xappluns)
{
{
Write-Host "updating the XtremIO settings for $VMHost"
(get-vmhost $VMHost | Get-EsxCli).storage.core.device.set($null, $device.Device, $null, $null, $null, $null, $null, 256, $null)
}
}
}

#check the settings
foreach ($VMHost in (get-vmhost | sort))
{
$VMHost.Name
(Get-EsxCli -VMHost $VMHost).storage.core.device.list() | where vendor -eq "XtremIO" | select Vendor, Device, NoofoutstandingIOswithcompetingworlds | ft
}
