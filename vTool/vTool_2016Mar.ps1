<#
.SYNOPSIS
    A handy multi purpose tool to get those things done quickly
.DESCRIPTION
    This is an onging VMware tool to help those with an VMware environment to automate certain repetative tasks
.NOTES
    File Name      : vTool.ps1
    Author         : gajendra d ambi
    Date           : January 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>

##Start of the script##
Clear-Host  # Clear the screen.

#--------Start of Collection of Functions of automation---------#



#--------End of Collection of Functions of automation---------#

#------------------------------Start of Collection of Menu Functions-------------------------------#
#Start of vdsLoadBalancingMenu
function vdsLoadBalancingMenu
{
 do {
 do {
     Write-Host "Make sure you are connected to a vCenter" -ForegroundColor Yellow
     Write-Host "`nvdsLoadBalancingMenu" -BackgroundColor White -ForegroundColor Black
     Write-Host "
     A. LoadBalanceIP
     B. LoadBalanceLoadBased
     C. LoadBalanceSrcMac
     D. LoadBalanceSrcId
     E. ExplicitFailover" #options to choose from
   
     Write-Host "
     X. Previous Menu
     Y. Main Menu
     Z. Exit" -BackgroundColor Black -ForegroundColor Green #return to main menu
    
     $choice = Read-Host "choose one of the above"  #Get user's entry
     $ok     = $choice -match '^[abcdexyz]+$'
     if ( -not $ok) { write-host "Invalid selection" -BackgroundColor Red }
    } until ( $ok )
    switch -Regex ($choice) 
    {
    "A" { Write-Host you chose A }
    "B" { Write-Host you chose B }
    "C" { Write-Host you chose C }
    "D" { Write-Host you chose D }
    "E" { Write-Host you chose E }
    "X" { vdsMenu }
    "Y" { MainMenu }  
    }
    } until ( $choice -match "Z" )
}
#end of vdsLoadBalancingMenu

#Start of VMKservicesMenu
function VMKservicesMenu
{
 do {
 do {
     Write-Host "Make sure you are connected to a vCenter" -ForegroundColor Yellow
     Write-Host "`nVMKservicesMenu" -BackgroundColor White -ForegroundColor Black
     Write-Host "
     A. Enable VMotion
     B. Enable VsanTraffic
     C. Enable FaultTolerance
     D. Enable ManagementTraffic
     E. Disable VMotion
     F. Disable VsanTraffic
     G. Disable FaultTolerance
     H. Disable ManagementTraffic" #options to choose from
   
     Write-Host "
     X. Previous Menu
     Y. Main Menu
     Z. Exit" -BackgroundColor Black -ForegroundColor Green #return to main menu
    
     $choice = Read-Host "choose one of the above"  #Get user's entry
     $ok     = $choice -match '^[abcdefghxyz]+$'
     if ( -not $ok) { write-host "Invalid selection" -BackgroundColor Red }
    } until ( $ok )
    switch -Regex ($choice) 
    {
    "A" { Write-Host you chose A }
    "B" { Write-Host you chose B }
    "C" { Write-Host you chose C }
    "D" { Write-Host you chose D }
    "E" { Write-Host you chose E }
    "F" { Write-Host you chose F }    
    "G" { Write-Host you chose G }
    "H" { Write-Host you chose H }
    "X" { HostMenu }
    "Y" { MainMenu } 
    }
    } until ( $choice -match "Z" )
}
#end of VMKservicesMenu

#Start of vdsMenu
function vdsMenu
{
 do {
 do {
     Write-Host "Make sure you are connected to a vCenter" -ForegroundColor Yellow
     Write-Host "`nvdsMenu" -BackgroundColor White -ForegroundColor Black
     Write-Host "
     A. Create VDS
     B. Create dvPortgroup
     C. Add hosts to VDS
     D. Load balancing
     E. (L3)TCP/IP stack" #options to choose from
   
     Write-Host "
     X. Previous Menu
     Y. Main Menu
     Z. Exit" -BackgroundColor Black -ForegroundColor Green #return to main menu
    
     $choice = Read-Host "choose one of the above"  #Get user's entry
     $ok     = $choice -match '^[abcdexyz]+$'
     if ( -not $ok) { write-host "Invalid selection" -BackgroundColor Red }
    } until ( $ok )
    switch -Regex ($choice) 
    {
    "A" { Write-Host you chose A }
    "B" { Write-Host you chose B }
    "C" { Write-Host you chose C }
    "D" { vdsLoadBalancingMenu }
    "E" { Write-Host you chose E }
    "X" { ClusterMenu }
    "Y" { MainMenu }  
    }
    } until ( $choice -match "Z" )
}
#end of vdsMenu

#Start of PowerMgmtMenu
function PowerMgmtMenu
{
 do {
 do {
     Write-Host "Make sure you are connected to a vCenter" -ForegroundColor Yellow
     Write-Host "`nPowerMgmtMenu" -BackgroundColor White -ForegroundColor Black
     Write-Host "
     A. Enter Maintenance Mode
     B. Exit Maintenance Mode
     C. Shutdown
     D. Reboot" #options to choose from
   
     Write-Host "
     X. Previous Menu
     Y. Main Menu
     Z. Exit" -BackgroundColor Black -ForegroundColor Green #return to main menu
    
     $choice = Read-Host "choose one of the above"  #Get user's entry
     $ok     = $choice -match '^[abcdxyz]+$'
     if ( -not $ok) { write-host "Invalid selection" -BackgroundColor Red }
    } until ( $ok )
    switch -Regex ($choice) 
    {
    "A" { Write-Host you chose A }
    "B" { Write-Host you chose B }
    "C" { Write-Host you chose C }
    "D" { Write-Host you chose D }
    }
    } until ( $choice -match "Z" )
}
#end of PowerMgmtMenu

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
     Z. Exit" -BackgroundColor Black -ForegroundColor Green

     $user   = [Environment]::UserName
     $choice = Read-Host "choose one of the above"  #Get user's entry
     $ok     = $choice -match '^[abcdefghijklmnopqrstxyz]+$'
     if ( -not $ok) { write-host "Invalid selection" -BackgroundColor Red }
    } until ( $ok )
    switch -Regex ($choice) 
    {
     "A" { Write-Host "Create vSwitch            "}
     "B" { Write-Host "Update NumPorts           "}
     "C" { Write-Host "Update Nic                "}
     "D" { Write-Host "Update MTU                "}
     "E" { Write-Host "Create VM Portgroup       "}
     "F" { Write-Host "Create VMkernel Portgroup "}
     "G" { Write-Host "Rename Portgroup          "}
     "H" { Write-Host "Update Portgroup's Vlan   "}
     "I" { Write-Host "LoadBalanceIP             "}
     "J" { Write-Host "LoadBalanceSrcMac         "}
     "K" { Write-Host "LoadBalanceSrcId          "}
     "L" { Write-Host "ExplicitFailover          "}
     "M" { Write-Host "Delete Portgroup          "}
     "N" { Write-Host "Enable AllowPromiscuous   "}
     "O" { Write-Host "Enable ForgedTransmits    "}
     "P" { Write-Host "Enable MacChanges         "}
     "Q" { Write-Host "Disable AllowPromiscuous  "}
     "R" { Write-Host "Disable ForgedTransmits   "}
     "S" { Write-Host "Disable MacChanges        "}
     "T" { Write-Host "Delete Portgroup          "}
     "X" { vCenterMenu }
     "Y" { MainMenu }    
    }
    } until ( $choice -match "Z" )
}
#End of VssMenu

#Start of MainMenu
function MainMenu
{
 do {
 do {
     $version = 'Mar2016'
     Write-Host -BackgroundColor Black -ForegroundColor Cyan  "`nvTool $version"
     Write-Host -BackgroundColor White -ForegroundColor Black "`nMain Menu"
     Write-Host "
     A. vCenter
     B. Standalone Hosts" #options to choose from...

     write-host "
     Z - Exit" -ForegroundColor Yellow #exits the script

     $user   = [Environment]::UserName
     $choice = Read-Host "Hi $user, choose one of the above"  #Get user's entry
     $ok     = $choice -match '^[abz]+$'
     if ( -not $ok) { write-host "Invalid selection" -BackgroundColor Red }
    } until ( $ok )
    switch -Regex ($choice) 
    {
    "A" { vCenterMenu }
    "B" { Write-Host you chose B }
    }
    } until ( $choice -match "Z" )
    #if ($choice -eq "z") { exit }
}
#end of MainMenu

#Start of DrsRulesMenu
function DrsRulesMenu
{
 do {
 do {
     Write-Host "Make sure you are connected to a vCenter" -ForegroundColor Yellow
     Write-Host "`nDrsRulesMenu" -BackgroundColor White -ForegroundColor Black
     Write-Host "
     A. VMAffinity
     B. VMAntiAffinity
     C. DrsVmGroup
     D. DrsHostGroup
     E. DRSVMToHostRule
     " #options to choose from
   
     Write-Host "
     X. Previous Menu
     Y. Main Menu
     Z. Exit" -BackgroundColor Black -ForegroundColor Green #return to main menu
    
     $choice = Read-Host "choose one of the above"  #Get user's entry
     $ok     = $choice -match '^[abcdexyz]+$'
     if ( -not $ok) { write-host "Invalid selection" -BackgroundColor Red }
    } until ( $ok )
    switch -Regex ($choice) 
    {
    "A" { Write-Host you chose A }
    "B" { Write-Host you chose B }
    "C" { Write-Host you chose C }
    "D" { Write-Host you chose D }
    "E" { Write-Host you chose E }
    "X" { ClusterMenu }
    "Y" { MainMenu }  
    }
    } until ( $choice -match "Z" )
}
#end of DrsRulesMenu

#Start of ClusterMenu
function ClusterMenu
{
 do {
 do {
     Write-Host "Make sure you are connected to a vCenter" -ForegroundColor Yellow
     Write-Host "`nClusterMenu" -BackgroundColor White -ForegroundColor Black
     Write-Host "
     A. Create Cluster
     B. Add Hosts
     C. Configure HA
     D. Configure DRS
     E. DRS rules
     F. Create vApp
     G. Customer Datastores" #options to choose from
   
     Write-Host "
     X. Previous Menu
     Y. Main Menu
     Z. Exit" -BackgroundColor Black -ForegroundColor Green #return to main menu
    
     $choice = Read-Host "choose one of the above"  #Get user's entry
     $ok     = $choice -match '^[abcdefgxyz]+$'
     if ( -not $ok) { write-host "Invalid selection" -BackgroundColor Red }
    } until ( $ok )
    switch -Regex ($choice) 
    {
    "A" { Write-Host you chose A }
    "B" { Write-Host you chose B }
    "C" { Write-Host you chose C }
    "D" { Write-Host you chose D }
    "E" { DrsRulesMenu }
    "F" { Write-Host you chose G }
    "G" { Write-Host you chose H }
    "X" { vCenterMenu }
    "Y" { MainMenu }  
    }
    } until ( $choice -match "Z" )
}
#end of ClusterMenu

#Start of HostServicesMenu
function HostServicesMenu
{
 do {
 do {
     Write-Host "Make sure you are connected to a vCenter" -ForegroundColor Yellow
     Write-Host "`nHostServicesMenu" -BackgroundColor White -ForegroundColor Black
     Write-Host "
     A. DCUI           [Direct Console UI]
     B. TSM            [ESXi Shell]
     C. TSM-SSH        [SSH]
     D. lbtd           [Load-Based Teaming Daemon]
     E. lwsmd          [Active Directory Service]
     F. ntpd           [NTP Daemon]
     G. pcscd          [PC/SC Smart Card Daemon]
     H. sfcbd-watchdog [CIM Server]
     I. snmpd          [SNMP Server]
     J. vmsyslogd      [Syslog Server]
     K. vprobed        [VProbe Daemon]
     L. vpxa           [VMware vCenter Agent]
     M. xorg           [X.Org Server]
     " #options to choose from
   
     Write-Host "
     X. Previous Menu
     Y. Main Menu
     Z. Exit" -BackgroundColor Black -ForegroundColor Green #return to main menu
    
     $choice = Read-Host "choose one of the above"  #Get user's entry
     $ok     = $choice -match '^[abcdefghijklmxyz]+$'
     if ( -not $ok) { write-host "Invalid selection" -BackgroundColor Red }
    } until ( $ok )
    switch -Regex ($choice) 
    {
    "A" { Write-Host you chose A }
    "B" { Write-Host you chose B }
    "C" { Write-Host you chose C }
    "D" { Write-Host you chose D }
    "E" { Write-Host you chose E }
    "F" { Write-Host you chose F }
    "G" { Write-Host you chose G }
    "H" { Write-Host you chose H }
    "I" { Write-Host you chose I }
    "J" { Write-Host you chose J }
    "K" { Write-Host you chose K }
    "L" { Write-Host you chose L }
    "M" { Write-Host you chose M }
    "X" { HostMenu }
    "Y" { MainMenu }
    }
    } until ( $choice -match "Z" )
}
#end of HostServicesMenu

#Start of HostPerfMenu
function HostPerfMenu
{
 do {
 do {
     Write-Host "Make sure you are connected to a vCenter" -ForegroundColor Yellow
     Write-Host "`nHostPerfMenu" -BackgroundColor White -ForegroundColor Black
     Write-Host "
     A. High Performance
     B. Balanced performance
     C. LowPower Mode
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
    "A" { Write-Host you chose A }
    "B" { Write-Host you chose B }
    "C" { Write-Host you chose C }
    "X" { HostMenu }
    "Y" { MainMenu }
    }
    } until ( $choice -match "Z" )
}
#end of HostPerfMenu

#Start of PowerMgmtMenu
function PowerMgmtMenu
{
 do {
 do {
     Write-Host "Make sure you are connected to a vCenter" -ForegroundColor Yellow
     Write-Host "`nPowerMgmtMenu" -BackgroundColor White -ForegroundColor Black
     Write-Host "
     A. Enter Maintenance Mode
     B. Exit Maintenance Mode
     C. Shutdown
     D. Reboot" #options to choose from
   
     Write-Host "
     X. Previous Menu
     Y. Main Menu
     Z. Exit" -BackgroundColor Black -ForegroundColor Green #return to main menu
    
     $choice = Read-Host "choose one of the above"  #Get user's entry
     $ok     = $choice -match '^[abcdxyz]+$'
     if ( -not $ok) { write-host "Invalid selection" -BackgroundColor Red }
    } until ( $ok )
    switch -Regex ($choice) 
    {
    "A" { Write-Host you chose A }
    "B" { Write-Host you chose B }
    "C" { Write-Host you chose C }
    "D" { Write-Host you chose D }
    }
    } until ( $choice -match "Z" )
}
#end of PowerMgmtMenu

#Start of HostMenu
function HostMenu
{
 do {
 do {
     Write-Host "Make sure you are connected to a vCenter" -ForegroundColor Yellow
     Write-Host "`nHostMenu" -BackgroundColor White -ForegroundColor Black
     Write-Host "
     A. SNMP
     B. Syslog settings
     C. DNS settings
     D. NTP settings
     E. TCP/IP advance settings
     F. Firewall Settings
     G. Scratch partition
     H. Performance settings
     I. Core dump settings
     J. Power Management (shutdown, reboot, maintenance)
     k. Enable/disable services
     L. IPv6
     M. VMKernel Services

     W. Others" #[Others menu is to include miscellaneous settings as per business needs] #options to choose from
   
     Write-Host "
     X. Previous Menu
     Y. Main Menu
     Z. Exit" -BackgroundColor Black -ForegroundColor Green #return to main menu
    
     $choice = Read-Host "choose one of the above"  #Get user's entry
     $ok     = $choice -match '^[abcdefghijklmwxyz]+$'
     if ( -not $ok) { write-host "Invalid selection" -BackgroundColor Red }
    } until ( $ok )
    switch -Regex ($choice) 
    {
    "A" { Write-Host you chose A }
    "B" { Write-Host you chose B }
    "C" { Write-Host you chose C }
    "D" { Write-Host you chose D }
    "E" { Write-Host you chose E }
    "F" { Write-Host you chose F }
    "G" { Write-Host you chose G }
    "H" { HostPerfMenu }
    "I" { Write-Host you chose I }
    "J" { PowerMgmtMenu }
    "K" { HostServicesMenu }
    "L" { Write-Host you chose L }
    "M" { VMKservicesMenu }
    "W" { Write-Host you chose HostsOtherMenu. This is not implemented yet }
    "X" { vCenterMenu }
    "Y" { MainMenu }  
    }
    } until ( $choice -match "Z" )
}
#end of HostMenu

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
    "Y" { HostMenu }
    }
    } until ( $choice -match "Z" )
}
#end of vCenterMenu

#------------------------------End of Collection of Menu Functions-------------------------------#

MainMenu
##End of Script##