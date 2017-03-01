<#
.SYNOPSIS
    check whether mob is disable don the esxi host or not.
.DESCRIPTION
    USe the advanced setting option of the powercli to get the mob status.
.NOTES
    File Name      : MobChecker.ps1
    Author         : gajendra d ambi
    Prerequisite   : PowerShell V2 over Vista and upper.
    Copyright      - None
.LINK
    Script posted over:
    https://github.com/gajuambi/vmware/
#>
get-vmhost | get-advancedsetting Config.HostAgent.plugins.solo.enableMob | Select-Object Entity, @{Expression="Value";Label="MOb Enabled"}
