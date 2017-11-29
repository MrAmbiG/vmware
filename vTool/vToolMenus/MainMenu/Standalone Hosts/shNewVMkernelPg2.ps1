#start of function
function shNewVMkernelPg 
{
<#
.SYNOPSIS
    Create New VMware Standard Swiportgroup on all hosts
.DESCRIPTION
    This will need the 1st host's ip address and the number of subsequent hosts that you want to configure(which should be in series of the ip address).
    Lets say you have 10 esxi hosts and the 1st host's ip is 1.1.1.1 then you have to provide the 1st host's ip address and the number of hosts
    as an input to this script which will do +1 to the last octet of the 1st host's ip address and connect to all of the 10 hosts and 
    Then it will create a new vmkernel portgroup based on your input.
.NOTES
    File Name      : shNewVMkernelPg.ps1
    Author         : gajendra d ambi
    Date           : April 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#Start of script#
$vss  = Read-Host "name of the vSwitch?"
$pg   = Read-Host "name of the portgroup?"
$vlan = Read-Host "vlan?"

$ip    = Read-Host "What is the 1st vmkernel ip address?"
$mask  = Read-Host "subnet mask?"
$vmk   = Read-Host "vmk number? ex: vmk7?"

$stopWatch = [system.diagnostics.stopwatch]::startNew()
$stopWatch.Start()

get-vmhost | Get-VirtualSwitch -Name $vss | New-VirtualPortGroup -Name $pg -VLanId $vlan -Confirm:$false

$a     = $ip.Split('.')[0..2]   
#first 3 octets of the ip address
$b     = [string]::Join(".",$a)

#last octet of the ip address
$c     = $ip.Split('.')[3]
$c     = [int]$c

 foreach ($vmhost in (get-vmhost | sort)) {
          $esxcli = get-esxcli $vmhost -v2

          # add vmkernel   
          $esxcliset = $esxcli.network.ip.interface.add 
          $args = $esxcliset.CreateArgs()
          $args.interfacename = "$vmk"
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
          $esxcliset.Invoke($args)  
}
$stopWatch.Stop()
Write-Host "Elapsed Runtime:" $stopWatch.Elapsed.Hours "Hours" $stopWatch.Elapsed.Minutes "minutes and" $stopWatch.Elapsed.Seconds "seconds." -BackgroundColor White -ForegroundColor Black
}#End of function

