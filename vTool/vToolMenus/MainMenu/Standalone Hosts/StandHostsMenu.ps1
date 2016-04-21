
#Start of vdsMenu
function StandHostsMenu
{
 do {
 do {     
     Write-Host "`StandHostsMenu" -BackgroundColor White -ForegroundColor Black
     Write-Host "
     A. Create virtual Standard Switch
     B. Create virtual Machine Portgroup
     C. Create VMkernel Portgroup
     D. Rename Portgroups
     E. Add Nics to vSwitch
     F. Remove VM portgroup
     F. Remove VMkernel portgroup" #options to choose from
   
     Write-Host "
     X. Previous Menu
     Y. Main Menu
     Z. Exit" -BackgroundColor Black -ForegroundColor Green #return to main menu
    
     $choice = Read-Host "choose one of the above" #Get user's entry
     $ok     = $choice -match '^[abcdefgxyz]+$'
     if ( -not $ok) { write-host "Invalid selection" -BackgroundColor Red }
    } until ( $ok )
    switch -Regex ($choice) 
    {
    "A" { shNewVss }
    "B" { shNewVMPg }
    "C" { shNewVMkernelPg }
    "D" { shRenamePg }
    "E" { shAddNic }
    "F" { shShootVmPg }
    "g" { shShootVmkPg }

    "X" { vCenterMenu }
    "Y" { MainMenu }  
    }
    } until ( $choice -match "Z" )
}
#end of vdsMenu