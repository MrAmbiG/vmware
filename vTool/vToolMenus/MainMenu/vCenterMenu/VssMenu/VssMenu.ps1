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
     D  Update MTU
     E. Create VM Portgroup
     F. Create VMkernel Portgroup
     G. Rename Portgroup
     H. Update Portgroup's Vlan
     I. LoadBalanceIP
     J. LoadBalanceSrcMac
     K. LoadBalanceSrcId
     L. ExplicitFailover
     M. Delete VM Portgroup
     N. Enable AllowPromiscuous
     O. Enable ForgedTransmits
     P. Enable MacChanges
     Q. Disable AllowPromiscuous
     R. Disable ForgedTransmits
     S. Disable MacChanges
     T. Delete VMkernel Portgroup  
     U. Sync portgroup with vSwitch(inerit all properties of vswitch to portgroup)   
     " #options to choose from...

     Write-Host "
     X. Previous Menu
     Y. Main Menu
     Z. Exit 
     " -BackgroundColor White -ForegroundColor Black

     $user   = [Environment]::UserName
     $choice = Read-Host "choose one of the above"  #Get user's entry
     $ok     = $choice -match '^[abcdefghijklmnopqrstuxyz]+$'
     if ( -not $ok) { write-host "Invalid selection" -BackgroundColor Red }
    } until ( $ok )
    switch -Regex ($choice) 
    {
     "A" { CreateVss }
     "B" { VssPorts }
     "C" { VssNic }
     "D" { VssMtu }
     "E" { VssVmPg }
     "F" { VssVmkPg }
     "G" { PgRename }
     "H" { PgVlan }
     "I" { Pglbip }
     "J" { Pglbsm }
     "K" { Pglbsi }
     "L" { Pgef }
     "M" { ShootVmPg }
     "N" { VssPmOn }
     "O" { VssFtOn }
     "P" { VssMcOn }
     "Q" { VssPmOff }
     "R" { VssFtOff }
     "S" { VssMcOff }
     "T" { ShootVmkPg }
     "U" { PgSync }
     "X" { vCenterMenu }
     "Y" { MainMenu }      
    }
    } until ( $choice -match "Z" )
}
#End of VssMenu