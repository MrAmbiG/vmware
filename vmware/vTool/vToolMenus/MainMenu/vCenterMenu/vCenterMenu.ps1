
#Start of vCenterMenu
function vCenterMenu
{
 do {
 do {
     Write-Host "Make sure you are connected to a vCenter" -ForegroundColor Yellow
     Write-Host "`nvCenterMenu" -BackgroundColor White -ForegroundColor Black
     Write-Host "
     A. Cluster
     B. Host
     C. vSwitch
     D. dvSwitch" #options to choose from
   
     Write-Host "
     Y. Main Menu
     Z. Exit" -BackgroundColor Black -ForegroundColor Green #return to main menu
    
     $choice = Read-Host "choose one of the above"  #Get user's entry
     $ok     = $choice -match '^[abcdyz]+$'
     if ( -not $ok) { write-host "Invalid selection" -BackgroundColor Red }
    } until ( $ok )
    switch -Regex ($choice) 
    {
    "A" { ClusterMenu }
    "B" { HostMenu }
    "C" { VssMenu }
    "D" { vdsMenu }
    "Y" { MainMenu }
    }
    } until ( $choice -match "Z" )
}
#end of vCenterMenu