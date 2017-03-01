<#
.SYNOPSIS
    Make powershell run powercli commands
.DESCRIPTION
    This will enable you to have powercli commands and modules in powershell every time you launch powershell.
.NOTES
    File Name      : PClitoPShell.ps1
    Author         : gajendra d ambi
    Date           : January 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/MrAmbiG/vmware
#>

#Start of Script
If ((Test-Path $Profile) -eq "False") {New-Item -path $profile -type file -force}
[System.Collections.ArrayList]$imports = @(
"#VMware Modules to load on powershell startup#",
"Import-Module VMware.VimAutomation.Core     -ErrorAction SilentlyContinue",
"Import-Module VMware.VimAutomation.Vds      -ErrorAction SilentlyContinue",
"Import-Module VMware.VimAutomation.Cis.Core -ErrorAction SilentlyContinue",
"Import-Module VMware.VimAutomation.Storage  -ErrorAction SilentlyContinue",
"Import-Module VMware.VimAutomation.vROps    -ErrorAction SilentlyContinue",
"Import-Module VMware.VimAutomation.HA       -ErrorAction SilentlyContinue",
"Import-Module VMware.VimAutomation.License  -ErrorAction SilentlyContinue",
"Import-Module VMware.VimAutomation.Cloud    -ErrorAction SilentlyContinue",
"Import-Module VMware.VimAutomation.PCloud   -ErrorAction SilentlyContinue",
"Import-Module VMware.VumAutomation          -ErrorAction SilentlyContinue",
"#VMware Snapins#",
"Add-PSSnapin VMware.VimAutomation.Cis.Core  -ErrorAction SilentlyContinue",
"Add-PSSnapin VMware.VimAutomation.Cloud     -ErrorAction SilentlyContinue",
"Add-PSSnapin VMware.VimAutomation.Core      -ErrorAction SilentlyContinue",
"Add-PSSnapin VMware.VimAutomation.HA        -ErrorAction SilentlyContinue",
"Add-PSSnapin VMware.VimAutomation.License   -ErrorAction SilentlyContinue",
"Add-PSSnapin VMware.VimAutomation.PCloud    -ErrorAction SilentlyContinue",
"Add-PSSnapin VMware.VimAutomation.SDK       -ErrorAction SilentlyContinue",
"Add-PSSnapin VMware.VimAutomation.Storage   -ErrorAction SilentlyContinue",
"Add-PSSnapin VMware.VimAutomation.Vds       -ErrorAction SilentlyContinue",
"Add-PSSnapin VMware.VimAutomation.vROps     -ErrorAction SilentlyContinue",
"Add-PSSnapin VMware.VumAutomation           -ErrorAction SilentlyContinue"
)

$file  = $profile
$lines = gc $file | get-unique
#ac $file "#VMware Modules to load on powershell startup#"
foreach ($line in $lines){$imports.remove($line)}
foreach ($item in $imports) {ac $file "$item"}