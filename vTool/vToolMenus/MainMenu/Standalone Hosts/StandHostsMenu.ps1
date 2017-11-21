#Start of StandHostsMenu
function StandHostsMenu
{
 do {
 do {
     write-Host -BackgroundColor Black -ForegroundColor White '
     to offer suggestions, collaborate, please contact
     twitter.com/@MrAmbiG1'   
     Write-Host "`StandHostsMenu" -BackgroundColor White -ForegroundColor Black
     Write-Host "
     A. Connect to standalone hosts
     B. Create virtual Standard Switch
     C. Create virtual Machine Portgroup
     D. Create VMkernel Portgroup
     E. Rename Portgroups
     F. Add Nics to vSwitch
     G. Remove VM portgroup
     H. Remove VMkernel portgroup
     I. Change Ip address and gateway of a vmkernel" #options to choose from
   
     Write-Host "
     X. Previous Menu
     Y. Main Menu
     Z. Exit" -BackgroundColor Black -ForegroundColor Green #return to main menu
    
     $choice = Read-Host "choose one of the above" #Get user's entry
     $ok     = $choice -match '^[abcdefghixyz]+$'
     if ( -not $ok) { write-host "Invalid selection" -BackgroundColor Red }
    } until ( $ok )
    switch -Regex ($choice) 
    {
    "A" { shGetShHosts }
    "B" { shNewVss }
    "C" { shNewVMPg }
    "D" { shNewVMkernelPg }
    "E" { shRenamePg }
    "F" { shAddNic }
    "G" { shShootVmPg }
    "H" { shShootVmkPg }
    "I" { IpChanger }

    "X" { vCenterMenu }
    "Y" { MainMenu }  
    }
    } until ( $choice -match "Z" )
}
#end of StandHostsMenu