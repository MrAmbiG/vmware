<#
.SYNOPSIS
    Adjust performance settings on esxi hosts
.DESCRIPTION
    This will change the performance settings on your esxi hosts. You get to choose from
    High performance, Balanced and Lowpower. Based on your choise the power setting for the esxi host will be changed.
.NOTES
    File Name      : fun_PerfSet.ps1
    Author         : gajendra d ambi
    Date           : February 2016
    recommended    : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>

#start of script
#start of function
function fun_PerfSet {
Write-Host "
1 High performance
2 Balanced
3 LowPower" -ForegroundColor Yellow
Write-Host "choose one of the above" -ForegroundColor Yellow
$option = Read-Host ""
$cluster = "*"
 foreach ($vmhost in (get-cluster $cluster | get-vmhost)) {
 (Get-View (Get-VMHost $vmhost | Get-View).ConfigManager.PowerSystem).ConfigurePowerPolicy($option)
 }
}
#End of script
fun_PerfSet
#End of function
