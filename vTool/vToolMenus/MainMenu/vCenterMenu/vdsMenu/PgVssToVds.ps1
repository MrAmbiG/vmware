#start of function
function PgVssToVds
{
<#
.SYNOPSIS
    Migrate Portgroup from Vss to Vds.
.DESCRIPTION
    This will migrate vmkernel portgroup from vswitch to dvswitch
.NOTES
    File Name      : PgVssToVds.ps1
    Author         : gajendra d ambi
    Date           : June 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: VCE Internal
#>
Write-Host "this will work on only those hosts which are part of the VDS" -BackgroundColor Black -ForegroundColor White
$vds = Read-Host "name of the vds?"
$pg  = Read-Host "name of the source portgroup on vss?" 
$dpg = Read-Host "name of the destination portgroup on vds?"
$cluster = Read-Host "Name of the cluster?"
$vmhosts = Get-cluster $cluster| get-vmhost | sort

foreach ($vmhost in $vmhosts)
    {$vmhost.Name
     $vmk = Get-VMHostNetworkAdapter -VMHost $vmhost | where PortgroupName -eq $pg
     Set-VMHostNetworkAdapter -PortGroup $dpg -VirtualNic $vmk -Confirm:$false
     Get-VMHost $vmhost | Get-VirtualPortGroup -Standard -Name $pg | Remove-VirtualPortGroup -Confirm:$false
    }
}#End of function
PgVssToVds
