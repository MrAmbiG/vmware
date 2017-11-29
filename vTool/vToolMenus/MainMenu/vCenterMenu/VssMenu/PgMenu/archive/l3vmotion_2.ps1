#start of function
function l3vmotion
{
<#
.SYNOPSIS
    Configure l3 vmotion.
.DESCRIPTION
    It will
    create the l3 vmotion portgroup
    add vmk to the portgroup
    assign vlan to the portgroup
    add ip, subnet mask to the portgroup
    enable netstack l3 vmotion for the portgroup
    1. update the default gateway manually for now
.NOTES
    File Name      : l3vmotion.ps1
    Author         : gajendra d ambi
    Date           : June 2016
    Prerequisite   : PowerShell v4+, powercli 6.3+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/MrAmbiG/vmware
    https://communities.vmware.com/thread/519794?start=0&tstart=0 (inok)
#>
#Start of Script
Write-Host "
Don't forget to add gateway after it's completion
" -BackgroundColor White -ForegroundColor Black


$cluster = "E0900-NMXD-MB"
$vss     = "vSwitch0"
$pg      = "vcesys-esx-L3vmotion"
$vlan    = "3165"
$ip      = "10.3.165.101"
$mask    = "255.255.255.0"
$vmk     = "vmk2"
$gw      = "10.3.165.254"
$nw      = "10.3.165.0/24"

$stopWatch = [system.diagnostics.stopwatch]::startNew()
$stopWatch.Start()

$a     = $ip.Split('.')[0..2]   
#first 3 octets of the ip address
$b     = [string]::Join(".",$a)

#last octet of the ip address
$c     = $ip.Split('.')[3]
$c     = [int]$c

$vmhosts = get-cluster $cluster | get-vmhost | sort
#foreach ($vmhost in $vmhosts)
# {
# Get-VMHost $vmhost | Get-VirtualSwitch -Name $vss | New-VirtualPortGroup $pg -VLanId $vlan -Confirm:$false #creating new VM portgroup
# $esxcli  = get-vmhost $vmhost | get-esxcli
# $esxcli.network.ip.route.ipv4.add("$gw", "vmotion", "$nw") #adds default route gateway
# $esxcli.network.ip.netstack.add($false, "vmotion") #enabling and adding vmotion tcp/ip stack (netstack)
# $esxcli.network.ip.interface.add($null, $null, "$vmk", $null, "1500", "vmotion", "$pg")
# 
# $esxcli.network.ip.interface.ipv4.set("$vmk", "$b.$(($c++))", "$mask", $null, "static") #update ip informaiton to the vmk 
# 
# }

  foreach ($vmhost in $vmhosts) {
  $vmhost.name
  get-vmhost $vmhost | get-virtualswitch -Name $vss | New-VirtualPortGroup -Name $pg -VLanId $vlan -Confirm:$false
        $esxcli = get-vmhost $vmhost | get-esxcli -v2
        $esxcliset1 = $esxcli.network.ip.interface.add 
        $args1 = $esxcliset1.CreateArgs()
        $args1.interfacename = "$vmk"
        $args1.netstack = "vmotion"
        $args1.mtu = "$mtu"
        $args1.portgroupname = "$pg"
        $esxcliset1.Invoke($args1)

        $esxcliset2 = $esxcli.network.ip.interface.ipv4.set 
        $args2 = $esxcliset2.CreateArgs()
        $args2.interefacename = "$vmk"
        $args2.type = "static"
        $args2.ipv4 = "$b.$(($c++))"
        $args2.netmask = "$mask"
        $esxcliset2.Invoke($args2)
 }

}#End of function

l3vmotion