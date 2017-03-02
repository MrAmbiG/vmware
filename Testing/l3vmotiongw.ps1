#connect-viserver 10.12.214.150 -User administrator@vsphere.local -Password VMwar3!!
$vmhosts = get-cluster AMP2_Mgmt | get-vmhost | sort
$vmhost  = $vmhosts[0]
$esxcli  = get-vmhost $vmhost| get-esxcli
$pg      = "test"
$gw = "10.108.67.1"
$nw = "10.108.67.0/24"
$vmk = "vmk7"
$ip = "10.108.67.67"
$mask = "255.255.255.0"

#$esxcli.network.ip.netstack.add($false, "vmotion") $esxcli.network.ip.route.ipv4.add($gw, "vmotion", $nw) #adds default route gateway
#$esxcli.network.ip.interface.add($null, $null, "$vmk", $null, "1500", "vmotion", "$pg")
#$esxcli.network.ip.interface.ipv4.set("$vmk", "$ip", "$mask", $null, "static")

