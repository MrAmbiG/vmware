#Start of function
function IpChanger 
{
<#
.SYNOPSIS
    Changes the ip address and gateway of the given vmkernel
.DESCRIPTION
    Imports esxcli in powercli to update the vmkernel's networking details
.NOTES
    File Name      : IpChanger.ps1
    Author         : gajendra d ambi
    updated        : July 2017
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/MrAmbig
#>
#Start of Script
Write-Host "
A CSV file will be opened (open in excel/spreadsheet)
populate the values,
save & close the file,
Hit Enter to proceed
" -ForegroundColor Blue -BackgroundColor White
$csv = "$PSScriptRoot/HostVds.csv"
get-process | Select-Object OldIp,NewIp,username,password,subnetMask | Export-Csv -Path $csv -Encoding ASCII -NoTypeInformation
Start-Process $csv
Read-Host "Hit Enter/Return to proceed"

$csv = Import-Csv $csv

  foreach ($line in $csv) 
 {  # importing data from csv and go line by line
    $OldIp = $($line.OldIp)  
    $user  = $($line.username)  
    $pass  = $($line.password)
    $NewIp  = $($line.NewIp)    
    $subnetMask  = $($line.subnetMask)

    # connect to each esxi host and update the ip and subnet mask for a given vmkernel
    Connect-VIServer $OldIp -User $user -Password $pass
    $esxcli = Get-VMHost $OldIp | Get-EsxCli -v2
    $esxcliset = $esxcli.network.ip.interface.ipv4.set
    $args = $esxcliset.CreateArgs()
    $args.interfacename = 'vmk0'
    $args.type = 'static'
    $args.ipv4 = $NewIp
    $args.netmask = $subnetMask
    $esxcliset.Invoke($args)
    Disconnect-VIServer * -Confirm:$false -ErrorAction SilentlyContinue
  }
 } #End of function