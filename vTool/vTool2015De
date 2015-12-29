<#
.SYNOPSIS
    A handy multi purpose tool to get those things done quickly
.DESCRIPTION
    This is an onging VMware tool to help those with an VMware environment to automate certain repetative tasks
.NOTES
    File Name      : vTool.ps1
    Author         : gajendra d ambi
    Date           : 2015
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>

#Start of the script

#Main Menu
    do {
        write-host ""
        write-host "A - vCenter"
        write-host "B - Standalone Hosts"
        write-host "Z - Exit"
        write-host -nonewline "Type your choice and press Enter: " -ForegroundColor DarkYellow
        
        $choice = read-host
        
        write-host ""
        
        $ok = $choice -match '^[abz]+$'
        
        if ( -not $ok) { write-host "Invalid selection" }
    } until ( $ok )
    
    switch -Regex ( $choice ) {
        "A" {
                 #vCenter Menu
				 #connect to the vCenter server
				 #connect-viserver
				 write-host "vCenter options"
                  do {
                      do {
                          write-host ""
                          write-host "A - vSwitch actions"   -ForegroundColor Green
						  write-host "B - dvSwitch actions"  -ForegroundColor Green
                          write-host "C - Cluster Actions"   -ForegroundColor Green
                          write-host "D - Host Actions"      -ForegroundColor Green
                          write-host "E - VM Actions"        -ForegroundColor Green              
                          write-host "Z - Exit"              -ForegroundColor Green
                          write-host -nonewline "Type your choice and press Enter: " -ForegroundColor DarkYellow
                          
                          $choice    = read-host
                          
                          write-host ""
                          
                          $ok = $choice -match '^[abcdez]+$'
                          
                          if ( -not $ok) { write-host "Invalid selection" }
                            } until ( $ok )
                      
                             switch -Regex ( $choice ) {
                          "A" {
                               #vSwitch Menu			                
				                write-host "vSwitch options"
                                 do {
                                     do {
                                         write-host ""
                                         write-host "A - Create vSwitch"       -ForegroundColor Yellow
				               		     write-host "B - Update vSwitch"       -ForegroundColor Yellow         
                                         write-host "C - Create Portgroup"     -ForegroundColor Yellow            
                                         write-host "D - Update Portgroup"     -ForegroundColor Yellow           
                                         write-host "E - Delete Portgroup"     -ForegroundColor Yellow             
                                         write-host "Z - Exit"                 -ForegroundColor Yellow           
                                         write-host -nonewline "Type your choice and press Enter: " -ForegroundColor DarkYellow
                                         
                                         $choice    = read-host
                                         
                                         write-host ""
                                         
                                         $ok = $choice -match '^[abcdez]+$'
                                         
                                         if ( -not $ok) { write-host "Invalid selection" }
                                           } until ( $ok )
                                     
                                            switch -Regex ( $choice ) {
                                         "A" {
                                              write-host "Create vSwitch"
                                             }
                                         "B" {
                                              do {
                                                   do {
                                                       write-host ""
                                                       write-host "A - NumPorts"         -foregroundcolor blue
                                                       write-host "B - Nic"              -foregroundcolor blue
                                                       write-host "C - Mtu"              -foregroundcolor blue
                                                       write-host "D - loadbalance"      -foregroundcolor blue
                                                       write-host "E - Security"         -foregroundcolor blue
                                                       write-host "" 
                                                       write-host "Z - Exit"             -foregroundcolor blue
                                                       write-host ""
                                                       write-host -nonewline "Type your choice and press Enter: " -ForegroundColor DarkYellow
                                                       
                                                       $choice = read-host
                                                       
                                                       write-host ""
                                                       
                                                       $ok = $choice -match '^[abcdez]+$'
                                                       
                                                       if ( -not $ok) { write-host "Invalid selection" }
                                                       } until ( $ok )
                                                   
                                                   switch -Regex ( $choice ) {
                                                       "A"
                                                          {
                                                              write-host "You entered 'NumPorts'"
                                                          }
                                                       
                                                       "B"
                                                          {
                                                              write-host "You entered 'Nic'"
                                                          }
                                               
                                                       "C"
                                                          {
                                                              write-host "You entered 'Mtu'"
                                                          }
                                                       
                                                       "D"
                                                          {
                                                           do {
                                                               do {
                                                                   write-host ""
                                                                   write-host "A - LoadBalanceIP"
                                                                   write-host "B - LoadBalanceSrcMac"
                                                                   write-host "C - LoadBalanceSrcId"
                                                                   write-host "D - ExplicitFailover"
                                                                   write-host ""
                                                                   write-host "Z - Exit"
                                                                   write-host ""
                                                                   write-host -nonewline "Type your choice and press Enter: " -ForegroundColor DarkYellow
                                                                   
                                                                   $choice = read-host
                                                                   
                                                                   write-host ""
                                                                   
                                                                   $ok = $choice -match '^[abcdez]+$'
                                                                   
                                                                   if ( -not $ok) { write-host "Invalid selection" }
                                                                   } until ( $ok )
                                                               
                                                               switch -Regex ( $choice ) {
                                                                   "A"
                                                                      {
                                                                          write-host "You entered 'LoadBalanceIP'"
                                                                      }
                                                                   
                                                                   "B"
                                                                      {
                                                                          write-host "You entered 'LoadBalanceSrcMac'"
                                                                      }
                                                           
                                                                   "C"
                                                                      {
                                                                          write-host "You entered 'LoadBalanceSrcId'"
                                                                      }
                                                                   
                                                                   "D"
                                                                      {
                                                                          write-host "You entered 'ExplicitFailover'"
                                                                      }
                                                           
                                                                   "Z"
                                                                      {
                                                                          return
                                                                      }
                                                                 }
                                                             } until ( $choice -match "z" )
                                                          }
                                                       "E"
                                                          {
                                                              Write-Host "Security"
                                                          }
                                               
                                                       "Z"
                                                          {
                                                              return
                                                          }
                                                   }
                                               } until ( $choice -match "z" )
                                             }
                                         "C" {
                                              write-host "Create Portgroup"
                                             }
                                         "D" {
                                              write-host "Update Portgroup"
                                             }
                                         "E" {
                                              write-host "Delete Portgroup"
                                             }
                                         "Z" {
                                              return
                                             }
                                             
                                      }
                                  } until ( $choice -match "Z" )
            
                              }
                          "B" {
                               write-host "dvSwitch options"
                              }
                          "C" {
                               write-host "Cluster Actions"
                              }
                          "D" {
                               write-host "Host Actions"
                              }
                          "E" {
                               write-host "VM Actions"
                              }
                          "Z" {
                               return
                              }
                              
                       }
                   } until ( $choice -match "Z" )
            }
        "B" {
		     #standalone host's Menu
             write-host "Standalone Host's options" -BackgroundColor Green
		    }
                   
        "Z" {
		     return
			}

    } until ( $choice -match "Z" )
