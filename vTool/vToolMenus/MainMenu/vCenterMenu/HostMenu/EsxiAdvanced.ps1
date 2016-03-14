#start of function
function EsxiAdvanced 
{
<#
.SYNOPSIS
    Set value to a chosen advancedsettig
.DESCRIPTION
    This will ask set many of the esxi advancedsettings which are exposed in esxi>configuration>advancedsettings.
    It will require 2 inputs from the user.
    name of the advanced setting and value of the advancedsetting.
.NOTES
    File Name      : EsxiAdvanced.ps1
    Author         : gajendra d ambi
    Date           : March 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#Start of script#
$cluster = Read-Host "name of the cluster[type * to include all clusters]?"
$AdvSet  = Read-Host "name of the advancedsetting[case sensitive]?"
$value   = Read-Host "value for the advancedsetting?"

 foreach ($vmhost in (Get-Cluster $cluster)) 
 {
 Get-VMHost $vmhost | get-advancedsetting -Name $AdvSet | Set-AdvancedSetting -Value $value -Confirm:$false
 }#End of Script#
}#End of function