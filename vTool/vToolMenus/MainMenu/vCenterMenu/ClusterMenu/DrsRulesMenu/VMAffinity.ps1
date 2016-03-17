
#start of function
Function VMAffinity 
{
<#
.SYNOPSIS
    Create VMAffinity DRS Rule.
.DESCRIPTION
    This uses custom functions to create DRS VMAffinity rules between VMs where VMs will be made to stay on the same host by the DRS.
.NOTES
    File Name      : VMAffinity.ps1
    Author         : gajendra d ambi
    Date           : February 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>

#Start of Script

$drsrule = Read-Host "Type the Name of the DRS Rule"
$VMs     = Read-Host "Type the Name of the VMs (separated only by a comma and no spaces)"
New-DrsRule –Name $drsrule -Cluster $cluster –KeepTogether:$true –VM $VMs -Confirm:$false

#End of Script
} #End of function