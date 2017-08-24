#start of function
function vmkpin
{
<#
.SYNOPSIS
    pin vmk to software iscsi.
.DESCRIPTION
    pin vmk to software iscsi
.NOTES
    File Name      : vmkpin.ps1
    Author         : gajendra d ambi
    Date           : march 2017
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: VCE Internal
#>
$vmhosts = clusterHosts # custom function
$vmks = Read-Host "type the vmk numbers to pin, separated by a comma, ex:- vmk3,vmk4"
if ($vmks -match ',') {
$vmks = $vmks.split(',') | where {$_.Length -gt 2} }
$vmks = @($vmks)
foreach ($vmhost in $vmhosts)
    {
    $vmhost.Name
    $hba = Get-VMHostHba -VMHost $vmhost -Type iScsi | Where-Object {$_.Model -eq "iSCSI Software Adapter"}
    $esxcli = Get-VMHost $vmhost | Get-EsxCli -v2
    foreach ($vmk in $vmks)
        {$esxcliset = $esxcli.iscsi.networkportal.add
        $args = $esxcliset.CreateArgs()
        $args.adapter = $hba.device
        $args.nic = $vmk
        $esxcliset.Invoke($args)  }  }  }#end of function
