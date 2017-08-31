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

$cluster = Read-Host "Name of the cluster?"
$vss     = Read-Host "Name of the vSwitch?"
$pg      = Read-Host "name of the portgroup?"
$vlan    = Read-Host "vlan?"
$ip      = Read-Host "What is the 1st vmkernel ip address?"
$mask    = Read-Host "subnet mask?"
$vmk     = Read-Host "vmk number? ex: vmk7?"

$stopWatch = [system.diagnostics.stopwatch]::startNew()
$stopWatch.Start()

$a     = $ip.Split('.')[0..2]   
#first 3 octets of the ip address
$b     = [string]::Join(".",$a)

#last octet of the ip address
$c     = $ip.Split('.')[3]
$c     = [int]$c

$vmhosts = get-cluster $cluster | get-vmhost | sort
foreach ($vmhost in $vmhosts)
 {
 Get-VMHost $vmhost | Get-VirtualSwitch -Name $vss | New-VirtualPortGroup $pg -VLanId $vlan -Confirm:$false #creating new VM portgroup
 $esxcli  = get-vmhost $vmhost | get-esxcli
 $esxcli.network.ip.netstack.add($false, "vmotion") #enabling and adding vmotion tcp/ip stack (netstack)
 $esxcli.network.ip.interface.add($null, $null, "$vmk", $null, "1500", "vmotion", "$pg")
 $esxcli.network.ip.interface.ipv4.set("$vmk", "$b.$(($c++))", "$mask", $null, "static") #update ip informaiton to the vmk
 }

$stopWatch.Stop()
Write-Host "Elapsed Runtime:" $stopWatch.Elapsed.Hours "Hours" $stopWatch.Elapsed.Minutes "minutes and" $stopWatch.Elapsed.Seconds "seconds." -BackgroundColor White -ForegroundColor Black
 #End of Script#
}#End of function