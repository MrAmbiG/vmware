<#
.SYNOPSIS
   This will set the VM startup order
.DESCRIPTION
   Sets the startup delay for one VM at a time
.NOTES
    File Name      : VMstartup.ps1
    Author         : gajendra d ambi
    Date           : Auguest 2015
    Prerequisite   : PowerShell V3, powercli 5+ over Vista and upper.
    Copyright      - None
.LINK
    Script posted over: ambitech.blogspot.in
    
#>

#Start of Script

#plugin vmware commands to powershell if running in powershell
Add-PSSnapin VMware.VimAutomation.Core -ea "SilentlyContinue"

#connect to the esxi host
#Write-Host connect to the esxi host with the VMs
#Connect-VIServer

Write-Host please make sure you are connected only to the esxi host with the VMs in it -ForegroundColor Green

#variables
#name of the vm below
$vm         = ""
#order at which the vm should start. mention a number/integer ex:- 3
$order      = ""
#mention a number/integer. this value is in seconds. ex:- 60
$startdelay = ""
Set-VMStartPolicy -StartPolicy (Get-VMStartPolicy -VM $vm) `
        -StartAction PowerOn -StartOrder $order -StartDelay $startdelay

#End of Script
