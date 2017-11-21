#Start of VMKservicesMenu
function VMKservicesMenu
{
 do {
 do {
     write-Host -BackgroundColor Black -ForegroundColor White '
     to offer suggestions, collaborate, please contact
     twitter.com/@MrAmbiG1'
     Write-Host "Make sure you are connected to a vCenter" -ForegroundColor Yellow
     Write-Host "`nVMKservicesMenu" -BackgroundColor White -ForegroundColor Black
     Write-Host "
     A. Enable VMotion
     B. Enable VsanTraffic
     C. Enable FaultTolerance
     D. Enable ManagementTraffic
     E. Disable VMotion
     F. Disable VsanTraffic
     G. Disable FaultTolerance
     H. Disable ManagementTraffic" #options to choose from
   
     Write-Host "
     X. Previous Menu
     Y. Main Menu
     Z. Exit" -BackgroundColor Black -ForegroundColor Green #return to main menu
    
     $choice = Read-Host "choose one of the above"  #Get user's entry
     $ok     = $choice -match '^[abcdefghxyz]+$'
     if ( -not $ok) { write-host "Invalid selection" -BackgroundColor Red }
    } until ( $ok )
    switch -Regex ($choice) 
    {
    "A" { VmotionOn }
    "B" { VsanTrafficOn }
    "C" { FaultToleranceOn }
    "D" { ManagementTrafficOn }
    "E" { VMotionOff }
    "F" { VsanTrafficOff }    
    "G" { FaultToleranceOff }
    "H" { ManagementTrafficOff }
    "X" { HostMenu }
    "Y" { MainMenu } 
    }
    } until ( $choice -match "Z" )
}
#end of VMKservicesMenu