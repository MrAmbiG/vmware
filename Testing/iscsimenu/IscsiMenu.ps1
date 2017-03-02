#Start of IscsiMenu
function IscsiMenu
{
 do {
 do {
     Write-Host "Make sure you are connected to a vCenter" -ForegroundColor Yellow
     Write-Host "`nIscsiMenu" -BackgroundColor White -ForegroundColor Black
     Write-Host "
     A. enable software iscsi adapter
     B. pin vmk to software iscsi adapter
     C. iscsi delay ack
    " #options to choose from
   
     Write-Host "
     X. Previous Menu
     Y. Main Menu
     Z. Exit" -BackgroundColor Black -ForegroundColor Green #return to main menu
    
     $choice = Read-Host "choose one of the above"  #Get user's entry
     $ok     = $choice -match '^[abcxyz]+$'
     if ( -not $ok) { write-host "Invalid selection" -BackgroundColor Red }
    } until ( $ok )
    switch -Regex ($choice) 
    {
    "A" { softIscsi }
    "B" { vmkpin }
    "C" { write-host 'yet to come' }
    "X" { vCenterMenu }
    "Y" { MainMenu }  
    }
    } until ( $choice -match "Z" )
}#end of IscsiMenu