
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
     G. Add Datastores" #options to choose from
   
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
    "A" { CreateCluster }
    "B" { AddHosts }
    "C" { ConfigHA }
    "D" { ConfigDrs }
    "E" { DrsRulesMenu }
    "F" { CreateVapp }
    "G" { AddDatastores }
    "X" { vCenterMenu }
    "Y" { MainMenu }  
    }
    } until ( $choice -match "Z" )
}
#end of ClusterMenu