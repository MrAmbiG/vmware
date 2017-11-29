#Start of VMMenu
Function VMMenu
{
 do {
 do {         
     Write-Host -BackgroundColor White -ForegroundColor Black "`nVMMenu"
     Write-Host "
     A. Create vSwitch
     B. Update NumPorts  
     " #options to choose from...

     Write-Host "
     X. Previous Menu
     Y. Main Menu
     Z. Exit 
     " -BackgroundColor White -ForegroundColor Black

     $user   = [Environment]::UserName
     $choice = Read-Host "choose one of the above"  #Get user's entry
     $ok     = $choice -match '^[abxyz]+$'
     if ( -not $ok) { write-host "Invalid selection" -BackgroundColor Red }
    } until ( $ok )
    switch -Regex ($choice) 
    {
     "A" { Write-Host you chose a }
     "B" { Write-Host you chose b }
     "X" { vCenterMenu }
     "Y" { MainMenu }   
    }
    } until ( $choice -match "Z" )
}
#End of VMMenu