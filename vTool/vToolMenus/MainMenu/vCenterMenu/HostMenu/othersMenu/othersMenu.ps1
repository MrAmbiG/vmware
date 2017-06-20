#Start of othersMenu
function othersMenu
{
 do {
 do {
     Write-Host "Make sure you are connected to a vCenter" -ForegroundColor Yellow
     Write-Host "`nothersMenu" -BackgroundColor White -ForegroundColor Black
     Write-Host "
     A. check reachability
     " 
   
     Write-Host "
     X. Previous Menu
     Y. Main Menu
     Z. Exit" -BackgroundColor Black -ForegroundColor Green #return to main menu
    
     $choice = Read-Host "choose one of the above"  #Get user's entry
     $ok     = $choice -match '^[axyz]+$'
     if ( -not $ok) { write-host "Invalid selection" -BackgroundColor Red }
    } until ( $ok )
    switch -Regex ($choice) 
    {
    "A" { checkIpConnectivity }
    "X" { HostMenu }
    "Y" { MainMenu }  
    }
    } until ( $choice -match "Z" )
}#end of HostMenu