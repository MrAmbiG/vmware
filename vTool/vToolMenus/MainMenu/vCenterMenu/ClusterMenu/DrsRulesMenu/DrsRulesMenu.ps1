
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
    
     $choice = Read-Host "choose one of the above" #Get user's entry
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