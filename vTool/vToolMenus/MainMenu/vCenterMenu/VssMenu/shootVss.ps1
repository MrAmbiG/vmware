function ShootVss  # Start of function
{
<#
.SYNOPSIS
    Remove standard virtual switch
.DESCRIPTION
    This is an onging VMware tool to help those with an VMware environment to automate certain repetative tasks
.NOTES
    File Name      : ShootVss.ps1
    Author         : gajendra d ambi
    Date           : June 2017
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/MrAmbig/vmware
#>
##Start of the script##
$cluster = Read-Host "Cluster's Name?"
$vss = Read-Host "Standard Switch's Name?"
get-vmhost | Get-VirtualSwitch -Name $vss | Remove-VirtualSwitch -Confirm:$false
## End of script ##
}  # End of function