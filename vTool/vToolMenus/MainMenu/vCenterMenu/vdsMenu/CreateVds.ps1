 
#start of function
Function CreateVds 
{
<#
.SYNOPSIS
    Create VDS.
.DESCRIPTION
    This will create a vds on a chosen datacenter..
.NOTES
    File Name      : CreateVds.ps1
    Author         : gajendra d ambi
    Date           : March 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#Start of Script
$dc  = Read-Host "name of the datacenter?"
$ul  = Read-Host "number of uplinks?"
$dvs = Read-Host "name of the dvSwitch?"
New-VDSwitch -Name $dvs -Location $dc -NumUplinkPorts $ul -Confirm:$false
#End of Script
}#End of function
