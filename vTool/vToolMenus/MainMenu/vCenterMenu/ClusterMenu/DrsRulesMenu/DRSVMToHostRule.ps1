#start of function
Function DRSVMToHostRule 
{
<#
.SYNOPSIS
    Create DRSVMToHostRule DRS Rule.
.DESCRIPTION
    This uses custom functions to create DRS DRSVMToHostRule rules between VMs where VMs will be made to stay on the same host by the DRS.
.NOTES
    File Name      : DRSVMToHostRule.ps1
    Author         : gajendra d ambi
    Date           : February 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>

#Start of Script
$cluster    = Read-Host "Name of the Cluster?"
$drsrule    = Read-Host "Type the Name of the DRS Rule"
$vmgroup    = Read-Host "Type the Name of the VM group"
$hostgroup  = Read-Host "Type the Name of the Hostgroup"
New-DrsVMToHostRule -VMGroup $vmgroup -HostGroup $hostgroup -Name $drsrule -Cluster $cluster -AntiAffine -Mandatory

#End of Script
} #End of function