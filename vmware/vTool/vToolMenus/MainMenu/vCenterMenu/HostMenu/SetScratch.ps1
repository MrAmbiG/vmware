#start of function
function SetScratch 
{
<#
.SYNOPSIS
    Create & configure Scratch partition on Esxi hosts
.DESCRIPTION
    This will create scratch location on the local storage of the esxi hosts and then map that as the
    scratch location for that host. Please note that if the local storage of your esxi blades is of different
    format that '*-localstorage' then please change the line
    $ds            = Get-VMHost -name $vmhost | get-datastore -Name '*-localstorage'
    accordingly.
.NOTES
    File Name      : SetScratch.ps1
    Author         : gajendra d ambi
    Date           : March 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#Start of script#
$resetloc = get-location
$cluster  = Read-Host "name of the cluster[type * to include all clusters]?"
Write-Host "
Leave blank if there is just one datastore,
to create scratch on a datastore with it's name matching 'localstorage' type localstorage,
" -BackgroundColor White -ForegroundColor Black
$pattern  = Read-Host "?"
$pattern = "*"+$pattern+"*"

$stopWatch = [system.diagnostics.stopwatch]::startNew()
$stopWatch.Start()

foreach ($vmhost in (get-cluster $cluster | get-vmhost | sort)) {
 $vmhost        = (get-vmhost $vmhost).Name
 $scratchfolder = '.locker_'+($vmhost.Split('.')[0])
 $ds            = Get-VMHost -name $vmhost | get-datastore -Name $pattern
  $location = ($vmhost.Split('.')[0])
  New-PSDrive -Name $location -Root \ -PSProvider VimDatastore -Datastore ($ds) -Scope global
  Set-Location $location":"
  ni $scratchfolder -ItemType directory -ErrorAction SilentlyContinue
  Get-VMhost $vmhost | Get-AdvancedSetting -Name "ScratchConfig.ConfiguredScratchLocation" | Set-AdvancedSetting -Value "/vmfs/volumes/$ds/$scratchfolder" -confirm:$false 
  Set-Location $resetloc
  Remove-PSDrive $location
 }
 get-cluster $cluster | get-vmhost | sort | Get-AdvancedSetting -Name "ScratchConfig.ConfiguredScratchLocation" | select Entity, Value | fl

$stopWatch.Stop()
Write-Host "Elapsed Runtime:" $stopWatch.Elapsed.Hours "Hours" $stopWatch.Elapsed.Minutes "minutes and" $stopWatch.Elapsed.Seconds "seconds." -BackgroundColor White -ForegroundColor Black
#End of Script#
}#End of function