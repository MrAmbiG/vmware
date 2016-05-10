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
$user  = Read-Host "username?"
$pass  = Read-Host "password?"

Connect-VIServer $SHost, $DHost -User $user -Password $pass

#Replicate vSwitchs
foreach ($vss in (get-vmhost $SHost | Get-virtualswitch))
{
 get-vmhost $DHost | New-VirtualSwitch -Name $vss -Confirm:$false #creates vSwtch
}
 #Add vmnics
 foreach ($vmnic in ((get-vmhost $SHost | get-virtualswitch -Name $vss | Get-VMHostNetworkAdapter | Where Name -Match vmnic).Name)) #lists the added vmnics on the source host $vss switch
 {
  get-vmhost $DHost | Get-VirtualSwitch -Name $vss | New-VMHostNetworkAdapter $vmnic -Confirm:$false #add vmnic to the destination host
 }

 #NIC Teaming Policies
 foreach ($vss in (get-vmhost $SHost | Get-virtualswitch))
 {
  $ActiveNics = (get-vmhost $SHost | get-virtualswitch -Name $vss | Get-NicTeamingPolicy).ActiveNic
  foreach ($ActiveNic in $ActiveNics)
  {
   Get-VMHost $DHost | get-virtualswitch -Name $vss | Get-NicTeamingPolicy | Set-NicTeamingPolicy -MakeNicActive $ActiveNic -Confirm:$false #sets vmnics as active
  }
  $StandbyNics = (get-vmhost $SHost | get-virtualswitch -Name $vss | Get-NicTeamingPolicy).StandbyNic
  foreach ($StandbyNic in $StandbyNics)
  {
   Get-VMHost $DHost | get-virtualswitch -Name $vss | Get-NicTeamingPolicy | Set-NicTeamingPolicy -MakeNicStandby $StandbyNic -Confirm:$false #sets vmnics as Standby
  }
  $MakeNicUnuseds = (get-vmhost $SHost | get-virtualswitch -Name $vss | Get-NicTeamingPolicy).MakeNicUnused
  foreach ($MakeNicUnused in $MakeNicUnuseds)
  {
   Get-VMHost $DHost | get-virtualswitch -Name $vss | Get-NicTeamingPolicy | Set-NicTeamingPolicy -MakeNicUnused $MakeNicUnused -Confirm:$false #sets vmnics as Unused
  }
  #take the values of other nic teaming policies from the $SHost
  $BeaconInterval                 = (get-vmhost $SHost | get-virtualswitch -Name $vss | Get-NicTeamingPolicy).BeaconInterval
  $LoadBalancingPolicy            = (get-vmhost $SHost | get-virtualswitch -Name $vss | Get-NicTeamingPolicy).LoadBalancingPolicy
  $NetworkFailoverDetectionPolicy = (get-vmhost $SHost | get-virtualswitch -Name $vss | Get-NicTeamingPolicy).NetworkFailoverDetectionPolicy
  $NotifySwitches                 = (get-vmhost $SHost | get-virtualswitch -Name $vss | Get-NicTeamingPolicy).NotifySwitches
  $FailbackEnabled                = (get-vmhost $SHost | get-virtualswitch -Name $vss | Get-NicTeamingPolicy).FailbackEnabled
  $CheckBeacon                    = (get-vmhost $SHost | get-virtualswitch -Name $vss | Get-NicTeamingPolicy).CheckBeacon
  #set the above values to the $DHost
  Get-VMHost $DHost | get-virtualswitch -Name $vss | Get-NicTeamingPolicy | Set-NicTeamingPolicy -BeaconInterval $BeaconInterval -LoadBalancingPolicy $LoadBalancingPolicy -NetworkFailoverDetectionPolicy $NetworkFailoverDetectionPolicy -NotifySwitches $NotifySwitches -FailbackEnabled $FailbackEnabled -Confirm:$false
 } 


#Replicate Portgroups
foreach ($vss in (get-vmhost $SHost | Get-virtualswitch))
{
 foreach ($pg in (get-vmhost $SHost | Get-virtualswitch -name $vss | Get-virtualportgroup))
 {
  $vlan = (get-vmhost $SHost | Get-VirtualSwitch -Name $vss | Get-VirtualPortGroup -Name $pg).VLanId
  get-vmhost $DHost | Get-virtualswitch -Name $vss | New-VirtualPortGroup -Name $pg -VLanId $vlan -Confirm:$false #creates portgroup

  #NIC Teaming Policies
  $ActiveNics = (get-vmhost $SHost | get-virtualportgroup -Name $pg | Get-NicTeamingPolicy).ActiveNic
  foreach ($ActiveNic in $ActiveNics)
  {
   Get-VMHost $DHost | get-virtualportgroup -Name $pg | Get-NicTeamingPolicy | Set-NicTeamingPolicy -MakeNicActive $ActiveNic -Confirm:$false #sets vmnics as active
  }
  $StandbyNics = (get-vmhost $SHost | get-virtualportgroup -Name $pg | Get-NicTeamingPolicy).StandbyNic
  foreach ($StandbyNic in $StandbyNics)
  {
   Get-VMHost $DHost | get-virtualportgroup -Name $pg | Get-NicTeamingPolicy | Set-NicTeamingPolicy -MakeNicStandby $StandbyNic -Confirm:$false #sets vmnics as Standby
  }
  $MakeNicUnuseds = (get-vmhost $SHost | get-virtualportgroup -Name $pg | Get-NicTeamingPolicy).MakeNicUnused
  foreach ($MakeNicUnused in $MakeNicUnuseds)
  {
   Get-VMHost $DHost | get-virtualportgroup -Name $pg | Get-NicTeamingPolicy | Set-NicTeamingPolicy -MakeNicUnused $MakeNicUnused -Confirm:$false #sets vmnics as Unused
  }
  #take the values of other nic teaming policies from the $SHost
  $BeaconInterval                 = (get-vmhost $SHost | get-virtualportgroup -Name $pg | Get-NicTeamingPolicy).BeaconInterval
  $LoadBalancingPolicy            = (get-vmhost $SHost | get-virtualportgroup -Name $pg | Get-NicTeamingPolicy).LoadBalancingPolicy
  $NetworkFailoverDetectionPolicy = (get-vmhost $SHost | get-virtualportgroup -Name $pg | Get-NicTeamingPolicy).NetworkFailoverDetectionPolicy
  $NotifySwitches                 = (get-vmhost $SHost | get-virtualportgroup -Name $pg | Get-NicTeamingPolicy).NotifySwitches
  $FailbackEnabled                = (get-vmhost $SHost | get-virtualportgroup -Name $pg | Get-NicTeamingPolicy).FailbackEnabled
  $CheckBeacon                    = (get-vmhost $SHost | get-virtualportgroup -Name $pg | Get-NicTeamingPolicy).CheckBeacon
  #set the above values to the $DHost
  Get-VMHost $DHost | get-virtualportgroup -Name $pg | Get-NicTeamingPolicy | Set-NicTeamingPolicy -BeaconInterval $BeaconInterval -LoadBalancingPolicy $LoadBalancingPolicy -NetworkFailoverDetectionPolicy $NetworkFailoverDetectionPolicy -NotifySwitches $NotifySwitches -FailbackEnabled $FailbackEnabled -Confirm:$false
 }
}

#Replicate VMkernels
foreach ($pg in (get-vmhost $SHost | Get-virtualportgroup))
{if ((get-vmhost $SHost | Get-VirtualPortGroup -Name $pg).Port.Type -eq "host")
 {
  $vmk = (get-vmhost $SHost | Get-VirtualPortGroup -Name $pg | Get-VMHostNetworkAdapter -VMKernel).DeviceName
  if ($vmk -ne "vmk0")
  {
   $esxcli = Get-VMHost $DHost | get-esxcli -v2
   $args = $esxcli.network.ip.interface.add.CreateArgs()
   $args.interfacename = $vmk
   $args.portgroupname = $pg
   $esxcli.network.ip.interface.add.Invoke($args)   #adds vmkernel
  }
 }
}

#destination host's ip address (last octet) on vmk0 (presumebly management network)
$DHostIp        = (get-vmhost $DHost | Get-VMHostNetworkAdapter -VMKernel | where DeviceName -Match "vmk0").ExtensionData.Spec.Ip.IpAddress
$DHostIpLastOct = $DHostIp.split('.')[3]

#Replicate VMKernel Networking
foreach ($pg in (get-vmhost $SHost | get-virtualportgroup))
{
 if ((get-vmhost $SHost | Get-VirtualPortGroup -Name $pg).Port.Type -eq "host")
 {
  $vmk = (get-vmhost $SHost | Get-VirtualPortGroup -Name $pg | Get-VMHostNetworkAdapter -VMKernel).DeviceName
  if ($vmk -ne "vmk0")
   {
    $esxcli = Get-VMHost $DHost | get-esxcli -v2
    $args = $esxcli.network.ip.interface.add.CreateArgs()
    $args.interfacename = $vmk
    $args.portgroupname = $pg
    $esxcli.network.ip.interface.add.Invoke($args)    
            
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
}#End of Script

SyncEsxiNet