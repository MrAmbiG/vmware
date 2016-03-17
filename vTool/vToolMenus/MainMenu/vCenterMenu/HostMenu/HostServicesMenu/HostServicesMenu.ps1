
#Start of HostServicesMenu
function HostServicesMenu
{
 do {
 do {
     Write-Host "Make sure you are connected to a vCenter" -ForegroundColor Yellow
     Write-Host "`nHostServicesMenu" -BackgroundColor White -ForegroundColor Black
     Write-Host "
     A. DCUI           [Direct Console UI]
     B. TSM            [ESXi Shell]
     C. TSM-SSH        [SSH]
     D. lbtd           [Load-Based Teaming Daemon]
     E. lwsmd          [Active Directory Service]
     F. ntpd           [NTP Daemon]
     G. pcscd          [PC/SC Smart Card Daemon]
     H. sfcbd-watchdog [CIM Server]
     I. snmpd          [SNMP Server]
     J. vmsyslogd      [Syslog Server]
     K. vprobed        [VProbe Daemon]
     L. vpxa           [VMware vCenter Agent]
     M. xorg           [X.Org Server]
     " #options to choose from
   
     Write-Host "
     X. Previous Menu
     Y. Main Menu
     Z. Exit" -BackgroundColor Black -ForegroundColor Green #return to main menu
    
     $choice = Read-Host "choose one of the above"  #Get user's entry
     $ok     = $choice -match '^[abcdefghijklmxyz]+$'
     if ( -not $ok) { write-host "Invalid selection" -BackgroundColor Red }
    } until ( $ok )
    switch -Regex ($choice) 
    {
    "A" { SetDCUI }
    "B" { SetTSM }
    "C" { SetSSH }
    "D" { SetLbtd }
    "E" { Setlwsmd }
    "F" { Setntpd }
    "G" { Setpcscd }
    "H" { Setsfcbd }
    "I" { Setsnmpd }
    "J" { Setvmsyslogd }
    "K" { Setvprobed }
    "L" { Setvpxa }
    "M" { Setxorg }
    "X" { HostMenu }
    "Y" { MainMenu }
    }
    } until ( $choice -match "Z" )
}
#end of HostServicesMenu