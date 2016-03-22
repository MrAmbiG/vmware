#Start of HostMenu
function HostMenu
{
 do {
 do {
     Write-Host "Make sure you are connected to a vCenter" -ForegroundColor Yellow
     Write-Host "`nHostMenu" -BackgroundColor White -ForegroundColor Black
     Write-Host "
     A. SNMP
     B. Syslog settings
     C. DNS settings
     D. NTP settings
     E. Any Advanced setting
     F. Firewall Settings
     G. Scratch partition
     H. Performance settings
     I. Core dump settings
     J. Power Management (shutdown, reboot, maintenance)
     k. Enable/disable services
     L. IPv6
     M. VMKernel Services

     W. Others" #[Others menu is to include miscellaneous settings as per business needs] #options to choose from
   
     Write-Host "
     X. Previous Menu
     Y. Main Menu
     Z. Exit" -BackgroundColor Black -ForegroundColor Green #return to main menu
    
     $choice = Read-Host "choose one of the above"  #Get user's entry
     $ok     = $choice -match '^[abcdefghijklmwxyz]+$'
     if ( -not $ok) { write-host "Invalid selection" -BackgroundColor Red }
    } until ( $ok )
    switch -Regex ($choice) 
    {
    "A" { SetSnmp }
    "B" { SetSyslog }
    "C" { SetDNS }
    "D" { SetNTP }
    "E" { EsxiAdvanced }
    "F" { SetFirewall }
    "G" { SetScratch }
    "H" { HostPerfMenu }
    "I" { CoreDump }
    "J" { PowerMgmt }
    "K" { HostServicesMenu }
    "L" { SetIpv6 }
    "M" { VMKservicesMenu }
    "W" { Write-Host you chose others. This is not implemented yet }
    "X" { vCenterMenu }
    "Y" { MainMenu }  
    }
    } until ( $choice -match "Z" )
}
#end of HostMenu