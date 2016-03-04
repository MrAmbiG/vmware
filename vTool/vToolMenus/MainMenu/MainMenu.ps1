
#Start of MainMenu
function MainMenu
{
 do {
 do {
     $version = 'Feb2016'
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
    "A" { Write-Host you chose A }
    "B" { Write-Host you chose B }
    }
    } until ( $choice -match "Z" )
}
MainMenu
#end of MainMenu
