
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