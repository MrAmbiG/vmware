<#
.SYNOPSIS
    create portgroups on all vmware esxi hosts.
.DESCRIPTION
    This will create vswitchs on all of your hosts of a vcenter
.NOTES
    File Name      : fun_create_pg.ps1
    Author         : gajendra d ambi
    Date           : January 2016
    recommended    : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware   
#>

#start of script
#start of function
Function fun_create_pg {
Write-Host "options
           1 VM Portgroup 
           2 VMKernel Portgroup" -ForegroundColor Yellow

$type     = Read-Host "type 1 or 2"

 $cluster = read-host "name of the cluster?(hint:type * to include all clusters)"
 $vss     = read-host "name of the vSwitch?"
 $pg      = read-host "name of the portgroup?"
 $vlan    = read-host "VLAN?"

if ($type -eq 1) {Get-cluster $cluster | get-vmhost | get-virtualswitch -Name $vss | New-VirtualPortGroup -Name $pg -VLanId $vlan -Confirm:$false}

if ($type -eq 2) {
   $vmk   = Read-Host "vmk number? ex:- vmk9"
   $ip    = Read-Host "starting ip address?" 
   $mask  = Read-Host "subnet mask"          
   $a     = $ip.Split('.')[0..2]
   
   #first 3 octets of the ip address
   $b     = [string]::Join(".",$a)
   
   #last octet of the ip address
   $c     = $ip.Split('.')[3]
   $c     = [int]$c

   foreach ($vmhost in (get-cluster $cluster | get-vmhost | sort)) {
    get-vmhost $vmhost | get-virtualswitch -Name $vss | New-VirtualPortGroup -Name $pg -VLanId $vlan -Confirm:$false
   (get-vmhost $vmhost | Get-EsxCli).network.ip.interface.add($null, $null, "$vmk", $null, "1500", $null, "$pg")
   (get-vmhost $vmhost | Get-EsxCli).network.ip.interface.ipv4.set("$vmk", "$b.$(($c++))", "$mask", $null, "static")
  }
 }
}
#end of function
fun_create_pg
#end of script
