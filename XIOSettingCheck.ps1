<#
.SYNOPSIS
    Check the Queuedepth of the fnic and 
.DESCRIPTION
    This should help you to generate a VMware infrastructure audit report which includes most of the things that are required by a datacenter.
.NOTES
    File Name      : XioSettingCheck.ps1
    Author         : gajendra d ambi
    Date           : December 2015
    Prerequisite   : PowerShell v3+, powercli 6+ over Vista and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
    
#>

#Start of the script

#list hosts with xio
$xiohosts = $null,$null
foreach ($vmhost in (get-vmhost | sort))
{
 $devices = ((Get-EsxCli -VMHost $vmhost).storage.core.device.list()).Model
 
 if ($devices -contains "XtremApp")
 {
  $xiohosts += "$vmhost"
  }
   }
   $a = $xiohosts[2]
   
   foreach ($xiohost in $a)
   {
   $devices = (Get-EsxCli -VMHost $xiohost).storage.core.device.list()
   
   if ($devices.Model -contains "XtremApp")
   {
   Write-Host "collecting Section 14 : XremIO/XtremAPP Detected"
   
   foreach ($vmhost in (get-vmhost | sort))
   {
   $xappluns = (Get-EsxCli -VMHost $vmhost).storage.core.device.list()
   if ($xappluns.Model -contains "XtremApp")
   {
   
   write-host "collecting XtremIO information of the $Hostname" -ForegroundColor Green
   
   $Hostname                              = (get-vmhost $vmhost).ExtensionData.Config.Network.DnsConfig.HostName
   $Vendor                                = [string]::Join(", ",((Get-EsxCli -VMHost $vmhost).storage.core.device.list()).Vendor)
   $Device                                = [string]::Join(", ",((Get-EsxCli -VMHost $vmhost).storage.core.device.list()).Device)
   $FnicMaxQdepth                         = ((get-vmhost $vmhost | get-esxcli).system.module.parameters.list("fnic") | where Name -EQ fnic_max_qdepth).value
   $NoofoutstandingIOswithcompetingworlds = [string]::Join(", ",((Get-EsxCli -VMHost $vmhost).storage.core.device.list()).NoofoutstandingIOswithcompetingworlds)
   
   Write-Host $hostname fnic quedepth is $FnicMaxQdepth NoofoutstandingIOswithcompetingworlds is $NoofoutstandingIOswithcompetingworlds for $Device
   }
  }
 }
}

#End of script
