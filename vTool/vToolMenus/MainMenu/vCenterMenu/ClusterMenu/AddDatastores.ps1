#start of function
Function AddDatastores 
{
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
$csv = "$PSScriptRoot/AddLuns.csv"
get-process | Select-Object Cluster,LunID,DatastoreName,vmhba | Export-Csv -Path $csv -Encoding ASCII -NoTypeInformation
Start-Process $csv
Read-Host "Hit Enter/Return to proceed"

$stopWatch = [system.diagnostics.stopwatch]::startNew()
$stopWatch.Start()

$csv = Import-Csv $csv
 foreach ($line in $csv) #using trim() to make sure unnecessary spaces before or after any values in the csv files are removed
 {
  $cluster = $($line.Cluster)
  $cluster = $cluster.trim()

  $lunid   = $($line.LunID)
  $lunid   = $lunid.trim()

  $ds      = $($line.DatastoreName)
  $ds      = $ds.trim()

  $vmhba   = $($line.vmhba)
  $runtime = ":C0:T0:L$lunid"
  $runtime = $vmhba+$runtime
  $vmhost  = (get-cluster $cluster | get-vmhost)[0]
  $naa     = (Get-SCSILun -VMhost $vmhost -LunType Disk | where Runtime -eq $runtime).CanonicalName
  New-Datastore -VMHost $vmhost -Name $ds -Path $naa -vmfs -Confirm:$false
 }

 $cluster = $csv.Cluster | get-unique
 get-cluster $cluster | get-vmhost | Get-VMHostStorage -RescanAllHba

$stopWatch.Stop()
Write-Host "Elapsed Runtime:" $stopWatch.Elapsed.Hours "Hours" $stopWatch.Elapsed.Minutes "minutes and" $stopWatch.Elapsed.Seconds "seconds." -BackgroundColor White -ForegroundColor Black
#End of Script
}#End of function