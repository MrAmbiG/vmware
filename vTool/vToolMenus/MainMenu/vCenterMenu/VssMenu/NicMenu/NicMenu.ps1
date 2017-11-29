#Start of NicMenu
function NicMenu
{
 do {
 do {
     write-Host -BackgroundColor Black -ForegroundColor White '
     to offer suggestions, collaborate, please contact
     twitter.com/@MrAmbiG1'    
     Write-Host "`NicMenu" -BackgroundColor White -ForegroundColor Black
     Write-Host "
     A. vSwitch
     B. portgroup
     " #options to choose from
   
     Write-Host "
     X. Previous Menu
     Y. Main Menu
     Z. Exit" -BackgroundColor Black -ForegroundColor Green #return to main menu
    
     $choice = Read-Host "choose one of the above" #Get user's entry
     $ok     = $choice -match '^[abxyz]+$'
     if ( -not $ok) { write-host "Invalid selection" -BackgroundColor Red }
    } until ( $ok )
    switch -Regex ($choice) 
    {
    "A" { NicStatusVss }
    "B" { NicStatusPg }

    "X" { vCenterMenu }
    "Y" { MainMenu }  
    }
    } until ( $choice -match "Z" )
} #end of NicMenu