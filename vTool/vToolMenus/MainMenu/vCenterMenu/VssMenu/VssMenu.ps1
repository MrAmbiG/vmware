#Start of VssMenu
Function VssMenu
{
 do {
 do {         
     Write-Host -BackgroundColor White -ForegroundColor Black "`nVssMenu"
     Write-Host "
     A. Create vSwitch
     B. Update NumPorts
     C. Update Nic
     D. Update MTU    
     E. Enable AllowPromiscuous
     F. Enable ForgedTransmits
     G. Enable MacChanges
     H. Disable AllowPromiscuous
     I. Disable ForgedTransmits
     J. Disable MacChanges
     K. Remove vSwitch
     L. PORTGROUP OPTIONS [portgroup workflows]
     " #options to choose from...

     Write-Host "
     X. Previous Menu
     Y. Main Menu
     Z. Exit 
     " -BackgroundColor White -ForegroundColor Black

     $user   = [Environment]::UserName
     $choice = Read-Host "choose one of the above"  #Get user's entry
     $ok     = $choice -match '^[abcdefghijklmnopxyz]+$'
     if ( -not $ok) { write-host "Invalid selection" -BackgroundColor Red }
    } until ( $ok )
    switch -Regex ($choice) 
    {
     "A" { CreateVss }
     "B" { VssPorts }
     "C" { NicMenu }
     "D" { VssMtu }
     "E" { VssPmOn }
     "F" { VssFtOn }
     "G" { VssMcOn }
     "H" { VssPmOff }
     "I" { VssFtOff }
     "J" { VssMcOff }
     "K" { ShootVss }
     "L" { PgMenu }

     "X" { vCenterMenu }
     "Y" { MainMenu }  
    }
    } until ( $choice -match "Z" )
} #End of VssMenu
