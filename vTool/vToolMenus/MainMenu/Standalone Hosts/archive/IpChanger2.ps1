#Start of function
function IpChanger 
{
<#
.SYNOPSIS
    Changes the ip address and gateway of the given vmkernel
.DESCRIPTION
    Imports esxcli in powercli to update the vmkernel's networking details
.NOTES
    File Name      : IpChanger.ps1
    Author         : gajendra d ambi
    updated        : July 2017
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/MrAmbig
#>
#Start of Script
$OldIp = Read-Host 'original ip?'
$NewIp = Read-Host 'new ip?'
$user = Read-Host 'username?'
$pass = Read-Host 'password?'
$vmk = Read-Host 'which vmk? ex:vmk0'
$subnetMask = Read-Host 'subnet mask?'

    Connect-VIServer $OldIp -User $user -Password $pass
    $esxcli = Get-VMHost $OldIp | Get-EsxCli -v2
    $esxcliset = $esxcli.network.ip.interface.ipv4.set
    $args = $esxcliset.CreateArgs()
    $args.interfacename = "$vmk"
    $args.type = 'static'
    $args.ipv4 = $NewIp
    $args.netmask = $subnetMask
    $esxcliset.Invoke($args)
    Disconnect-VIServer * -Confirm:$false -ErrorAction SilentlyContinue
 } #End of function

IpChanger
