#Start of PgMenu
Function PgMenu
{
 do {
 do {
     write-Host -BackgroundColor Black -ForegroundColor White '
     to offer suggestions, collaborate, please contact
     twitter.com/@MrAmbiG1'       
     Write-Host -BackgroundColor White -ForegroundColor Black "`nVssMenu"
     Write-Host "
     A. Create VM Portgroup
     B. Create VMkernel Portgroup
     C. Rename Portgroup
     D. Update Portgroup's Vlan
     E. Delete VM Portgroup
     F. Delete VMkernel Portgroup  
     G. Sync portgroup with vSwitch(inherit all properties of vswitch to portgroup)
     H. Add TCP/IP stack (vmotion, provisioning etc.)
     I. LoadBalanceIP
     J. LoadBalanceSrcMac
     K. LoadBalanceSrcId
     L. ExplicitFailover
     M. L3 vmotion portgroup 
     " #options to choose from...

     Write-Host "
     X. Previous Menu
     Y. Main Menu
     Z. Exit 
     " -BackgroundColor White -ForegroundColor Black

     $user   = [Environment]::UserName
     $choice = Read-Host "choose one of the above"  # Get user's entry
     $ok     = $choice -match '^[abcdefghijklmnxyz]+$'
     if ( -not $ok) { write-host "Invalid selection" -BackgroundColor Red }
    } until ( $ok )
    switch -Regex ($choice) 
    {
     "A" { VssVmPg }
     "B" { VssVmkPg }
     "C" { PgRename }
     "D" { PgVlan }
     "E" { ShootVmPg }
     "F" { ShootVmkPg }
     "G" { PgSync }
     "H" { PgTcpIpStack }
     "I" { Pglbip }
     "J" { Pglbsm }
     "K" { Pglbsi }
     "L" { Pgef }
     "M" { l3vmotion2 }   
        
     "X" { VssMenu }
     "Y" { MainMenu }      
    }
    } until ( $choice -match "Z" )
} #End of PgMenu