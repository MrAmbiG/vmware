#start of function
function FaultToleranceOff 
{
<#
.SYNOPSIS
    Enable vMotion
.DESCRIPTION
    Enable vMotion across the Cluster
.NOTES
    File Name      : FaultToleranceOff.ps1
    Author         : gajendra d ambi
    Date           : Feb 2016
    recommended    : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#start of script
$cluster  = Read-Host "name of the cluster[type * to include all clusters]?"
$pg       = Read-Host "name of the portgroup?"
Get-Cluster $cluster | Get-VMHost | Get-VMHostNetworkAdapter | where PortGroupname -EQ $pg | Set-VMHostNetworkAdapter -FaultToleranceLoggingEnabled $false -Confirm:$false
} #End of function