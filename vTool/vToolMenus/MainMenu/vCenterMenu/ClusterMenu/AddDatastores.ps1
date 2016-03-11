
#start of function
Function AddDatastores {
<#
.SYNOPSIS
    Add datastores to a cluster.
.DESCRIPTION
    This will create a csv file whcih is opened in excel. Once you popuate the details, you have to save & close it. 
    Hit return/enter to proceed and the script will 
    add the datastores to the 1st host of the cluster
    rescan all the hosts of the cluster
.NOTES
    File Name      : AddDatastores.ps1
    Author         : gajendra d ambi
    Date           : March 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>

#Start of Script

New-VIProperty -Name "Runtime" -ObjectType "ScsiLun" -Value {
  param($scsilun)
  #http://www.lucd.info/2010/10/17/runtime-name-via-extensiondata-and-new-viproperty/
  #twitter/lucd22
  #many a times (for some storages) runtime is empty, thus using this scriptlet to populate/repopulate the same
  $storDev = $scsilun.VMHost.ExtensionData.Config.StorageDevice
  $key = ($storDev.PlugStoreTopology.Device | where {$_.Lun -eq $scsilun.Key}).Key
  $stordev.PlugStoreTopology.Path | where {$_.Device -eq $key} | %{
    $device = $_
    $adapterKey = ($stordev.PlugStoreTopology.Adapter | where {$_.Key -eq $device.Adapter}).Adapter
    $adapter = ($stordev.HostBusAdapter | where {$_.Key -eq $adapterKey}).Device
    $adapter + ":C" + $device.ChannelNumber + ":T" + $device.TargetNumber + ":L" + $device.LunNumber
  }
} -Force


Write-Host "
A CSV file will be opened (open in excel/spreadsheet)
populate the values,
save & close the file,
Hit Enter to proceed
" -ForegroundColor Blue -BackgroundColor White
$csv = "$PSScriptRoot/addhosts.csv"
get-process | Select-Object Cluster,LunID,DatastoreName | Export-Csv -Path $csv -Encoding ASCII -NoTypeInformation
Start-Process $csv
Read-Host "Hit Enter/Return to proceed"

$csv = Import-Csv $csv
 foreach ($line in $csv) 
 {
  $cluster = $($line.Cluster)
  $lunid   = $($line.LunID)
  $ds      = $($line.DatastoreName)
  $vmhost  = (get-cluster $cluster | get-vmhost)[0]
  $naa     = (Get-SCSILun -VMhost $vmhost -LunType Disk | where runtimename -eq vmhba0:C0:T0:L$lunid).CanonicalName
  New-Datastore -VMHost $vmhost -Name $datastore -Path $naa -vmfs -Confirm:$false
 }

 $cluster = $csv.Cluster | get-unique
 $cluster = [string]::Join(", ",$cluster)
 foreach ($a in (get-cluster $cluster | get-vmhost)) 
 {
  $a | Get-VMHostStorage -RescanAllHba | Out-Null
  Write-Host "Rescan of all HBAs on $a is complete" -ForegroundColor Green
 }

#End of Script
}#End of function
