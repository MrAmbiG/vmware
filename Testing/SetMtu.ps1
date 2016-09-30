function VssMtuMenu
{
<#
.SYNOPSIS
    Set mtu.
.DESCRIPTION
    This will set mtu for vswitch, dvswitch, portgroup, dvportgroup
.NOTES
    File Name      : VssMtuMenu.ps1
    Author         : gajendra d ambi
    Date           : September 2016
    Prerequisite   : PowerShell v4+, powercli 6.3+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/MrAmbiG/vmware
#>
#Start of Script
 do {
 do {
     Write-Host "`nVssMtuMenu" -BackgroundColor White -ForegroundColor Black
     Write-Host "
     A. vSwitch
     B. Standard Portgroup
     " #options to choose from
   
     Write-Host "
     Y. Main Menu
     Z. Exit" -BackgroundColor Black -ForegroundColor Green #return to main menu
    
     $choice = Read-Host "choose one of the above"  #Get user's entry
     $ok     = $choice -match '^[abyz]+$'
     if ( -not $ok) { write-host "Invalid selection" -BackgroundColor Red }
    } until ( $ok )
    switch -Regex ($choice) 
    {
    "A" { VssMtu }
    "B" { PgMtu }
    "Y" { vCenterMenu }
    }
    } until ( $choice -match "Z" )
#End of script
}