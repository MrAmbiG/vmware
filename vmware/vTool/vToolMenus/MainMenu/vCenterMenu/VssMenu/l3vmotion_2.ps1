#start of function
function l3vmotion
{
<#
.SYNOPSIS
    Configure l3 vmotion.
.DESCRIPTION
    It will
    create the l3 vmotion portgroup
    add vmk to the portgroup
    assign vlan to the portgroup
    add ip, subnet mask to the portgroup
    enable netstack l3 vmotion for the portgroup
    1. update the default gateway manually for now
.NOTES
    File Name      : l3vmotion.ps1
    Author         : gajendra d ambi
    Date           : June 2016
    Prerequisite   : PowerShell v4+, powercli 6.3+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/MrAmbiG/vmware
    https://communities.vmware.com/thread/519794?start=0&tstart=0 (inok)
#>
#Start of Script
Write-Host "
Don't forget to add gateway after it's completion
" -BackgroundColor White -ForegroundColor Black


$cluster = "E0900-NMXD-MB"
$vss     = "vSwitch0"
$pg      = "vcesys-esx-L3vmotion"
$vlan    = "3165"
$ip      = "10.3.165.101"
$mask    = "255.255.255.0"
$vmk     = "vmk2"
$gw      = "10.3.165.254"
$nw      = "10.3.165.0/24"

$stopWatch = [system.diagnostics.stopwatch]::startNew()
$stopWatch.Start()

$a     = $ip.Split('.')[0..2]   
#first 3 octets of the ip address
$b     = [string]::Join(".",$a)

#last octet of the ip address
$c     = $ip.Split('.')[3]
$c     = [int]$c

$vmhosts = get-cluster $cluster | get-vmhost | sort
foreach ($vmhost in $vmhosts)
 {
 Get-VMHost $vmhost | Get-VirtualSwitch -Name $vss | New-VirtualPortGroup $pg -VLanId $vlan -Confirm:$false #creating new VM portgroup
 $esxcli  = get-vmhost $vmhost | get-esxcli
 $esxcli.network.ip.route.ipv4.add("$gw", "vmotion", "$nw") #adds default route gateway
 $esxcli.network.ip.netstack.add($false, "vmotion") #enabling and adding vmotion tcp/ip stack (netstack)
 $esxcli.network.ip.interface.add($null, $null, "$vmk", $null, "1500", "vmotion", "$pg")
 
 $esxcli.network.ip.interface.ipv4.set("$vmk", "$b.$(($c++))", "$mask", $null, "static") #update ip informaiton to the vmk 
 
 }

 #$esxcli.network.ip.route.ipv4.add("10.1.165.254", "vmotion" ,"10.1.165.0/24")

###adding default gateway###
#Get Plink
#$PlinkLocation = $PSScriptRoot + "\Plink.exe" #http://www.virtu-al.net/2013/01/07/ssh-powershell-tricks-with-plink-exe/
#If (-not (Test-Path $PlinkLocation)){
#   Write-Host "Plink.exe not found, trying to download..."
#   $WC = new-object net.webclient
#   $WC.DownloadFile("http://the.earth.li/~sgtatham/putty/latest/x86/plink.exe",$PlinkLocation)
#   If (-not (Test-Path $PlinkLocation)){
#      Write-Host "Unable to download plink.exe, please download and add it to the same folder as this script"
#      Exit
#   } Else {
#      $PlinkEXE = Get-ChildItem $PlinkLocation
#      If ($PlinkEXE.Length -gt 0) {
#         Write-Host "Plink.exe downloaded, continuing script"
#      } Else {
#      Write-Host "Unable to download plink.exe, please download and add it to the same folder as this script"
#         Exit
#      }
#   }  
#}
#
##server's credentials
#$user     = Read-Host "Host's username?"
#$pass     = Read-Host "Host's password?"
#$gw       = Read-Host "Gateway?"
#
##copy plink to c:\ for now
#Copy-Item $PSScriptRoot\plink.exe C:\
#
#foreach ($vmhost in $vmhosts)
# {
#     If (Test-Connection $vmhost -count 1 -quiet) 
#    { 
#    Write-Host $vmhost.Name -ForegroundColor Black -BackgroundColor White
#    Get-VMHost $VMHost | Get-VMHostService | where {$_.Key -eq "TSM-SSH"} | Start-VMHostService -confirm:$false #start ssh    
#    echo y | C:\plink.exe -ssh $user@$VMHost -pw $pass "exit" #store ssh keys
#
#    C:\plink.exe -ssh -v -noagent $VMHost -l $user -pw $pass "esxcfg-route -N vmotion -a default $gw"
#
#    Get-VMHost $VMHost | Get-VMHostService | where {$_.Key -eq "TSM-SSH"} | Stop-VMHostService -confirm:$false #stop ssh
#    } else { Write-Host "cannot add gateway, reason: hostname cannot be resolved" -ForegroundColor yellow }
# }
#
$stopWatch.Stop()
Write-Host "Elapsed Runtime:" $stopWatch.Elapsed.Hours "Hours" $stopWatch.Elapsed.Minutes "minutes and" $stopWatch.Elapsed.Seconds "seconds." -BackgroundColor White -ForegroundColor Black
 #End of Script#
}#End of function

l3vmotion