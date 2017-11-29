#start of function
function l3vmotion2
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
    updates the gateway
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

$cluster = Read-Host "Name of the cluster?"
$vss     = Read-Host "Name of the vSwitch?"
$pg      = Read-Host "name of the portgroup?"
$vlan    = Read-Host "vlan?"
$ip      = Read-Host "What is the 1st vmkernel ip address?"
$mask    = Read-Host "subnet mask?"
$gateway = Read-Host "gateway?"
$vmk     = Read-Host "vmk number? ex: vmk7?"
$mtu     = Read-Host "mtu ?"

$a     = $ip.Split('.')[0..2]   
#first 3 octets of the ip address
$b     = [string]::Join(".",$a)

#last octet of the ip address
$c     = $ip.Split('.')[3]
$c     = [int]$c

$vmhosts = get-cluster $cluster | get-vmhost | sort
  foreach ($vmhost in $vmhosts) {    
    $vmhost.name
    $esxcli = get-vmhost $vmhost | get-esxcli -v2
    get-vmhost $vmhost | get-virtualswitch -Name $vss | New-VirtualPortGroup -Name $pg -VLanId $vlan -Confirm:$false
    # add vmotion netstack
    $esxcliset = $esxcli.network.ip.netstack.add
    $args = $esxcliset.CreateArgs()
    $args.disabled = $false
    $args.netstack = 'vmotion'
    $esxcli.network.ip.netstack.add
    $esxcliset.Invoke($args)
    
    # add vmkernel with netstack    
    $esxcliset = $esxcli.network.ip.interface.add 
    $args = $esxcliset.CreateArgs()
    $args.interfacename = "$vmk"
    $args.netstack = 'vmotion'
    $args.mtu = "$mtu"    
    $args.portgroupname = "$pg"    
    $esxcliset.Invoke($args)   
     
    # update networking to the vmkernel
    $esxcliset = $esxcli.network.ip.interface.ipv4.set
    $args = $esxcliset.CreateArgs()
    $args.interfacename = "$vmk"
    $args.type = "static"
    $args.ipv4 = "$b.$(($c++))"
    $args.netmask = "$mask"
    $args.gateway = "$gateway"
    $esxcliset.Invoke($args)    
 }
}#End of function