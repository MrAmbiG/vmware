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
     " #options to choose from...

     Write-Host "
     X. Previous Menu
     Y. Main Menu
     Z. Exit 
     " -BackgroundColor White -ForegroundColor Black

     $user   = [Environment]::UserName
     $choice = Read-Host "choose one of the above"  #Get user's entry
     $ok     = $choice -match '^[abcdefghijklmnopqrstxyz]+$'
     if ( -not $ok) { write-host "Invalid selection" -BackgroundColor Red }
    } until ( $ok )
    switch -Regex ($choice) 
    {
     "A" { Write-Host "Create vSwitch                "}
     "B" { Write-Host "Update NumPorts               "}
     "C" { Write-Host "Update Nic                    "}
     "D" { Write-Host "Update MTU                    "}
     "E" { Write-Host "Create VM Portgroup           "}
     "F" { Write-Host "Create VMkernel Portgroup     "}
     "G" { Write-Host "Rename Portgroup              "}
     "H" { Write-Host "Update Portgroup's Vlan       "}
     "I" { Write-Host "LoadBalanceIP                 "}
     "J" { Write-Host "LoadBalanceSrcMac             "}
     "K" { Write-Host "LoadBalanceSrcId              "}
     "L" { Write-Host "ExplicitFailover              "}
     "M" { Write-Host "Delete Portgroup              "}
     "N" { Write-Host "Enable AllowPromiscuous       "}
     "O" { Write-Host "Enable ForgedTransmits        "}
     "P" { Write-Host "Enable MacChanges             "}
     "Q" { Write-Host "Disable AllowPromiscuous      "}
     "R" { Write-Host "Disable ForgedTransmits       "}
     "S" { Write-Host "Disable MacChanges            "}
     "T" { Write-Host "Delete Portgroup              "}
     "X" { vCenterMenu }
     "Y" { MainMenu }      
    }
    } until ( $choice -match "Z" )
}
#End of VssMenu