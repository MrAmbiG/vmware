#start of function
function softIscsi
{
<#
.SYNOPSIS
    enable software iscsi adapater
.DESCRIPTION
    enable software iscsi adapater
.NOTES
    File Name      : softIscsi.ps1
    Author         : gajendra d ambi
    Date           : march 2017
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: VCE Internal
#>
$cluster = Read-Host 'name of the cluster?'
$vmhosts = get-cluster $cluster | get-vmhost | sort
foreach ($vmhost in $vmhosts)
{
$vmhost.Name
get-vmhoststorage $vmhost | set-vmhoststorage -softwareiscsienabled $True
}
}#end of function