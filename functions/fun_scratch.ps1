<#
.SYNOPSIS
    Create & configure scratch location for esxi hosts.
.DESCRIPTION
    This will create a scratch folder in the datastores with the name .locker-hostname and configure that as the sratch location.
    This is designed to look for the keyword -localstorage at the end of the name of the datastore. you may change this keyword to your liking if you so desire.
.NOTES
    File Name      : fun_scratch.ps1
    Author         : gajendra d ambi
    Date           : February 2016
    recommended    : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
    http://kb.vmware.com/selfservice/microsites/search.do?language=en_US&cmd=displayKC&externalId=1033696
#>

#start of script
#start of function
function fun_scratch {
$resetloc = get-location
$cluster  = Read-Host "name of the cluster[type * to include all clusters]?"
foreach ($vmhost in (get-cluster $cluster | get-vmhost | sort)) {
 $vmhost        = (get-vmhost $vmhost).Name
 $scratchfolder = '.locker_'+($vmhost.Split('.')[0])
 $ds            = Get-VMHost -name $vmhost | get-datastore -Name '*-localstorage'
  $location = ($vmhost.Split('.')[0])
  New-PSDrive -Name $location -Root \ -PSProvider VimDatastore -Datastore ($ds) -Scope global
  Set-Location $location":"
  ni $scratchfolder -ItemType directory -ErrorAction SilentlyContinue
  Get-VMhost $vmhost | Get-AdvancedSetting -Name "ScratchConfig.ConfiguredScratchLocation" | Set-AdvancedSetting -Value "/vmfs/volumes/$ds/$scratchfolder" -confirm:$false 
  Set-Location $resetloc
  Remove-PSDrive $location
 }
 get-cluster $cluster | get-vmhost | sort | Get-AdvancedSetting -Name "ScratchConfig.ConfiguredScratchLocation" | select Entity, Value | fl
}
#End of script
fun_scratch
#End of function
