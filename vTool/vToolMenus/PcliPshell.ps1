
#start of function
function PcliPshell 
{
<#
.SYNOPSIS
    Integrate powercli into powershell
.DESCRIPTION
    This will add pssnapins/modules of vmware powercli into powershell. You will get
    powercli core, vds and vum scriptlets/snapsins/modules in powershell which will enable you
    to create, run powercli scripts into powershell ISE since powercli itself lacks an IDE.
.NOTES
    File Name      : PcliPshell.ps1
    Author         : gajendra d ambi
    Date           : March 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#Start of script#
Add-PSSnapin VMware.VimAutomation.Core -ErrorAction SilentlyContinue
Import-Module VMware.VimAutomation.Core -ErrorAction SilentlyContinue
Add-PSSnapin VMware.VumAutomation -ErrorAction SilentlyContinue
Import-Module VMware.VumAutomation -ErrorAction SilentlyContinue
Add-PSSnapin VMware.VimAutomation.Vds -ErrorAction SilentlyContinue
Import-Module VMware.VimAutomation.Vds -ErrorAction SilentlyContinue
#End of Script#
}#End of function
