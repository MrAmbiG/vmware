#Start of function
function CoreDump 
{
<#
.SYNOPSIS
    configure Coredump on esxi hosts
.DESCRIPTION
    This will check the version of the esxi and based on the version of it, it will set the coredump settings on the host
.NOTES
    File Name      : CoreDump.ps1
    Author         : gajendra d ambi
    Date           : January 2016
    recommended    : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware   
#>

#start of the script
#start of the function

$DumpTarget = Read-Host "Type the DumpTarget?:"
$vmk        = Read-Host "Type the vmk number?:"

$stopWatch = [system.diagnostics.stopwatch]::startNew()
$stopWatch.Start()

 foreach ($vmhost in (get-vmhost | sort)) {
  if ((get-vmhost $vmhost).version -match 5.) {
  $esxcli = get-vmhost $VMHost | Get-EsxCli
  $esxcli.system.coredump.network.set($null, $vmk , $DumpTarget , "6500")
  $esxcli.system.coredump.network.set("true")
  $esxcli.system.coredump.network.get()
  }

  if ((get-vmhost $vmhost).version -match 6.) {
  $esxcli = get-vmhost $vmhost | get-esxcli
  $esxcli.system.coredump.network.set($null , $vmk , $null , $DumpTarget , "6500")
  $esxcli.system.coredump.network.set("true")
  $esxcli.system.coredump.network.get()
  }
 }

$stopWatch.Stop()
Write-Host "Elapsed Runtime:" $stopWatch.Elapsed.Hours "Hours" $stopWatch.Elapsed.Minutes "minutes and" $stopWatch.Elapsed.Seconds "seconds." -BackgroundColor White -ForegroundColor Black
#End of Script#
}#End of function