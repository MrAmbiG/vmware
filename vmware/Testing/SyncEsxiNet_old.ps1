function SyncEsxiNet
{
<#
.SYNOPSIS
    Clones the Standard network configuration.
.DESCRIPTION
    This will clone the vswitchs, portgroups
.NOTES
    File Name      : SyncEsxiNet.ps1
    Author         : gajendra d ambi
    Date           : May 2016
    Prerequisite   : PowerShell v4+, powercli 6.3+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#Start of Script
$SHost = Read-Host "name or address of the source host?"
$DHost = Read-Host "name or address of the destination host?"

 foreach ($vss in (get-vmhost $SHost | Get-virtualswitch))
 {
  get-vmhost $DHost | New-VirtualSwitch -Name $vss -Confirm:$false
   foreach ($pg in (get-virtualswitch $vss | get-virtualportgroup))
   {
    $vlan = (get-vmhost $SHost | Get-VirtualSwitch -Name $vss | Get-VirtualPortGroup -Name $pg).VLanId
    get-vmhost $DHost | Get-VirtualSwitch -Name $vss | New-VirtualPortGroup -Name $pg -VLanId $vlan -Confirm:$false
     if ((get-vmhost $SHost | Get-VirtualSwitch -Name $vss | Get-VirtualPortGroup -Name $pg).Port.Type -eq "host")
     {
      $vmk = (get-vmhost $SHost | Get-VirtualSwitch -Name $vss | New-VirtualPortGroup -Name $pg | Get-VMHostNetworkAdapter -VMKernel).DeviceName
      if ($vmk -ne "vmk0")
       {
        $esxcli = Get-VMHost $DHost | get-esxcli -v2
        $args = $esxcli.network.ip.interface.add.CreateArgs()
        $args.interfacename = $vmk
        $args.portgroupname = $pg
        $esxcli.network.ip.interface.add.Invoke($args)

        #destination host's ip address (last octet) on the $vmk
        $DHostIp        = (get-vmhost $DHost | Get-VMHostNetworkAdapter -VMKernel | where DeviceName -Match $vmk).ExtensionData.Spec.Ip.IpAddress
        $DHostIpLastOct = $DHostIp.split('.')[3]
                
        #source host's ip address (first 3 octet) on the $vmk
        $SHostIp     = (get-vmhost $SHost | Get-VMHostNetworkAdapter -VMKernel | where DeviceName -Match $vmk).ExtensionData.Spec.Ip.IpAddress
        $SHostMask   = (get-vmhost $SHost | Get-VMHostNetworkAdapter -VMKernel | where DeviceName -Match $vmk).ExtensionData.Spec.Ip.SubnetMask
        $SHostIptOct = $SHostIp.split('.')[0..2]
        $SHostIptOct = [string]::Join(".",($SHostIptOct))

        #new ip for the new $vmk on $pg for the destination host
        $vmkip = $SHostIptOct+"."+$DHostIpLastOct

        #add the $vmkip to $vmk on $pg on $DHost
        $esxcli = Get-VMHost $DHost | get-esxcli -v2
        $args   = $esxcli.network.ip.interface.ipv4.set.CreateArgs()
        $args.ipv4    = $vmkip
        $args.netmask = $SHostMask
        $esxcli.network.ip.interface.ipv4.set.Invoke($args)
       }
     }
   }
}











}#End of Script