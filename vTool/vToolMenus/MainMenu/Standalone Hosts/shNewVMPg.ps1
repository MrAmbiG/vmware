#start of function
function shNewVMPg 
{
<#
.SYNOPSIS
    Create New VMware Standard Swiportgroup on all hosts
.DESCRIPTION
    This will need the 1st host's ip address and the number of subsequent hosts that you want to configure(which should be in series of the ip address).
    Lets say you have 10 esxi hosts and the 1st host's ip is 1.1.1.1 then you have to provide the 1st host's ip address and the number of hosts
    as an input to this script which will do +1 to the last octet of the 1st host's ip address and  connect to all of the 10 hosts and 
    Then it will create a new virtual machine portgroup based on your input.
.NOTES
    File Name      : shNewVMPg.ps1
    Author         : gajendra d ambi
    Date           : April 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#Start of script#
shGetShHosts
$vss  = "name of the vSwitch?"
$pg   = "name of the portgroup?"
$vlan = "vlan?"
get-vmhost | Get-VirtualSwitch -Name $vss | New-VirtualPortGroup -Name $pg -VLanId $vlan -Confirm:$false

 #End of Script#
}#End of function