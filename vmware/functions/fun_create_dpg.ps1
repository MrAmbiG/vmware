<#
.SYNOPSIS
    create distributed portgroup.
.DESCRIPTION
    This will create distributed portgroup for your DVS
.NOTES
    File Name      : fun_create_dpg.ps1
    Author         : gajendra d ambi
    Date           : January 2016
    recommended    : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware   
#>

#start of script
#start of function
Function fun_create_dpg {
$csv = "$PSScriptRoot/dpg.csv"
if ($csv -ne $null){Remove-Item $csv -Force}
$csv >> "$PSScriptRoot/dpg.csv"
$csv = "$PSScriptRoot/dpg.csv"
$csv | select dvs, portgroup, vlan, ports | Export-Csv $csv

Write-Host "update the csv file with a text editor,save & close it & then hit enter" -ForegroundColor Yellow

start-process $csv
Read-Host "Hit Enter/Return to continue"
$csv = import-csv $csv
$csv

 foreach ($line in $csv){
 $dvs   = $($line.dvs)
 $pg    = $($line.portgroup)
 $vlan  = $($line.vlan)
 $ports = $($line.ports)
 Get-VDSwitch -Name $dvs | New-VDPortgroup -Name $pg -VlanId $vlan -NumPorts $ports
 }
}
#End of function
fun_create_dpg
#End of script
