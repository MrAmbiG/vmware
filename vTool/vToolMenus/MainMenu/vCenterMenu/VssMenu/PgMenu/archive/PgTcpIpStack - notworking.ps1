#start of function
function PgTcpIpStack
{
<#
.SYNOPSIS
    add tcp ip stack to host.
.DESCRIPTION
    It will add the following tcp ip stacks to the chosen hosts
    vmotion
    custom
.NOTES
    File Name      : PgTcpIpStack.ps1
    Author         : gajendra d ambi
    Date           : Aug 2017
    Prerequisite   : PowerShell v5+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/MrAmbiG/vmware    
#>
#Start of Script
Write-Host "
Don't forget to add gateway after it's completion
" -BackgroundColor White -ForegroundColor Black

$stackname = Read-Host 'Name of the TCP/IP stack? (ex:- "vmotion")'
$vmhosts = clusterHosts # custom function

$stopWatch = [system.diagnostics.stopwatch]::startNew()
$stopWatch.Start()

foreach ($vmhost in $vmhosts)
{$esxcli = get-vmhost $amphost | get-esxcli -v2
$esxcliset = $esxcli.network.ip.netstack.add.CreateArgs()
$args.disabled = $false
$args.netstack = $stackname
$esxcli.Invoke($args) }
Write-Host "now create vmkernel portgroups to utilize this new tcp/ip stack"

$stopWatch.Stop()
Write-Host "Elapsed Runtime:" $stopWatch.Elapsed.Hours "Hours" $stopWatch.Elapsed.Minutes "minutes and" $stopWatch.Elapsed.Seconds "seconds." -BackgroundColor White -ForegroundColor Black
 #End of Script#
}#End of function