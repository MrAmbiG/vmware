<#
.SYNOPSIS
    Rename portgroups.
.DESCRIPTION
    This will rename the portgroups in a vcenter of a cluster or for all hosts.
.NOTES
    File Name      : fun_rename_pg.ps1
    Author         : gajendra d ambi
    Date           : January 2016
    recommended    : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware   
#>

#start of script

Function fun_rename_pg {
$cluster = Read-Host "Name of the cluster(hint:type * to include all cluster):"
$oldpg   = Read-Host "Name of the current portgroup:"
$newpg   = Read-host "New name to the portgroup:"

foreach ($vmhost in (get-cluster $cluster | get-vmhost)) {get-vmhost $vmhost | get-virtualportgroup -Name $oldpg | set-virtualportgroup -Name $newpg}
}

#end of script
