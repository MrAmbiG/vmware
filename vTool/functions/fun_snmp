<#
.SYNOPSIS
    set snmp.
.DESCRIPTION
    Update snmp settings for esxi hosts
.NOTES
    File Name      : fun_snmp.ps1
    Author         : gajendra d ambi
    Date           : December 2015
    recommended    : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware   
#>

#Start of script
#start of function
Function fun_snmp {
$snmp   = Read-Host "Type the snmp target:"
$string = Read-Host "Type the snmp communities string:"
  foreach ($vmhost in (get-vmhost | sort)) {
  $esxcli = get-vmhost $vmhost | get-esxcli
  $esxcli.system.snmp.set($null,$null,$null,$null,$null,$null,$null,$null,$null,$null,$null,"true",$null,$null,$null,$null)
  $esxcli.system.snmp.set($null,$string,$null,$null,$null,$null,$null,$null,$null,$null,$null,$null,$null,$null,$null,$null)
  $esxcli.system.snmp.set($null,$null,$null,$null,$null,$null,$null,$null,$null,$null,$null,$null,$null,"$snmp/$string","$snmp/$string",$null)
  $esxcli.system.snmp.set($null,$null,"true",$null,$null,$null,$null,$null,$null,$null,$null,$null,$null,$null,$null,$null)
  $esxcli.system.snmp.get()
  }
 }
#end of function
fun_snmp
#End of script
