#start of function
function SetSnmp 
{
<#
.SYNOPSIS
    Configure SNMP
.DESCRIPTION
    This will configure SNMP using powercli on esxi hosts. It uses esxcli commands into powercli.
.NOTES
    File Name      : SetSnmp.ps1
    Author         : gajendra d ambi
    Date           : March 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#Start of script#
$vmhosts = clusterHosts # custom function
$snmp    = Read-Host "Type the snmp target"
$string  = Read-Host "Type the snmp communities string"

$stopWatch = [system.diagnostics.stopwatch]::startNew()
$stopWatch.Start()

  foreach ($vmhost in $vmhosts) {
        $esxcli = get-vmhost $vmhost | get-esxcli -v2
        $esxcliset = $esxcli.system.snmp.set
        $args = $esxcliset.CreateArgs()
        $args.communities = "$string"
        $args.enable = "true"
        $args.targets = "$snmp"
        $esxcli.Invoke($args) 
  }

$stopWatch.Stop()
Write-Host "Elapsed Runtime:" $stopWatch.Elapsed.Hours "Hours" $stopWatch.Elapsed.Minutes "minutes and" $stopWatch.Elapsed.Seconds "seconds." -BackgroundColor White -ForegroundColor Black
#End of Script#
}#End of function
