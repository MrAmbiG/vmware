#start of function
Function VssVmkPg 
{
<#
.SYNOPSIS
    update vmkernel portgroup on vSwitch.
.DESCRIPTION
    This will update vmkernel portgroup on a chosen standard vSwitch of hosts of a chosen cluster.    
.NOTES
    File Name      : VssVmkPg.ps1
    Author         : gajendra d ambi
    Date           : March 2016
    last update    : March 2017[added mtu option]
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#Start of Script
$cluster = Read-Host "name of the cluster[type * to include all clusters]?"
$vss     = Read-Host "name of the vSphere standard Switch?"
$pg      = Read-Host "Name of the portgroup?"
$vmk     = Read-Host "vmk number? ex:- vmk9"
$mtu     = Read-Host "mtu?"
$ip      = Read-Host "starting ip address?" 
$mask    = Read-Host "subnet mask"
$vlan    = Read-Host "Vlan?"

$stopWatch = [system.diagnostics.stopwatch]::startNew()
$stopWatch.Start()

$a       = $ip.Split('.')[0..2]
   
  #first 3 octets of the ip address
  $b     = [string]::Join(".",$a)
  
  #last octet of the ip address
  $c     = $ip.Split('.')[3]
  $c     = [int]$c

  foreach ($vmhost in (get-cluster $cluster | get-vmhost | sort)) {
  $vmhost.name
  get-vmhost $vmhost | get-virtualswitch -Name $vss | New-VirtualPortGroup -Name $pg -VLanId $vlan -Confirm:$false
  $esxcli = get-vmhost $vmhost | Get-EsxCli
  $esxcli.network.ip.interface.add($null, $null, "$vmk", $null, "$mtu", $null, "$pg")
  $esxcli.network.ip.interface.ipv4.set("$vmk", "$b.$(($c++))", "$mask", $null, "static")
 }

$stopWatch.Stop()
Write-Host "Elapsed Runtime:" $stopWatch.Elapsed.Hours "Hours" $stopWatch.Elapsed.Minutes "minutes and" $stopWatch.Elapsed.Seconds "seconds." -BackgroundColor White -ForegroundColor Black
 #End of Script#
}#End of function
VssVmkPg