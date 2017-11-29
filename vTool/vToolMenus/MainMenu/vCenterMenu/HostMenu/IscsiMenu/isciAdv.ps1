#start of function
function iscsiAdv
{
<#
.SYNOPSIS
    iscsi advanced options
.DESCRIPTION
    iscsi advanced options
.NOTES
    File Name      : iscsiAdv.ps1
    Author         : gajendra d ambi
    Date           : march 2017
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: VCE Internal
#>
#$cluster = Read-Host 'name of the cluster?'
$cluster = Read-host "cluster name?"
$vmhosts = get-cluster $cluster | get-vmhost | sort
foreach ($vmhost in $vmhosts[1])
{
$vmhost.Name
$hba = Get-VMHostHba -VMHost $vmhost -Type iScsi | Where-Object {$_.Model -eq "iSCSI Software Adapter"}
$esxcli = get-vmhost $vmhost | get-esxcli
foreach ($vmk in $vmks)
    {$esxcli.iscsi.adapter.param.set($hba.device,$false,'DelayedAck',$false) }
}
}#end of function
iscsiAdv