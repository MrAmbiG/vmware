<#
.SYNOPSIS
    Enable or disable services on a vmkernel/vmportgroup.
.DESCRIPTION
    This will create distributed portgroup for your DVS
.NOTES
    File Name      : fun_services.ps1
    Author         : gajendra d ambi
    Date           : february 2016
    recommended    : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware   
#>

#start of script
#start of function
Function fun_services {
$cluster   = Read-Host "name of the cluster[type * to include all clusters]?"
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
" -ForegroundColor Yellow

Write-Host "choose one of the above" -ForegroundColor Yellow
$option = ""

If (($option -EQ 'A') -or ($option -EQ 'a')) {  Write-Host "
  1. Turn On
  2. Turn Off
  3. Always On
  4. Always off
  "
  $choice  = read-host 'choose one of the above' -foregroundcolor green
  $service = 'DCUI'
  if ($choice -eq 1) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Start-vmhostservice} 
  if ($choice -eq 2) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Stop-vmhostservice}
  if ($choice -eq 3) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Start-vmhostservice | Set-VMHostService -Policy On}
  if ($choice -eq 4) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Stop-vmhostservice | Set-VMHostService -Policy off}  }
If (($option -EQ 'B') -or ($option -EQ 'b')) {  Write-Host "
  1. Turn On
  2. Turn Off
  3. Always On
  4. Always off
  "
  $choice  = read-host 'choose one of the above' -foregroundcolor green
  $service = 'TSM'
  if ($choice -eq 1) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Start-vmhostservice} 
  if ($choice -eq 2) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Stop-vmhostservice}
  if ($choice -eq 3) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Start-vmhostservice | Set-VMHostService -Policy On}
  if ($choice -eq 4) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Stop-vmhostservice | Set-VMHostService -Policy off}  }
If (($option -EQ 'C') -or ($option -EQ 'c')) {  Write-Host "
  1. Turn On
  2. Turn Off
  3. Always On
  4. Always off
  "
  $choice  = read-host 'choose one of the above' -foregroundcolor green
  $service = 'TSM-SSH'
  if ($choice -eq 1) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Start-vmhostservice} 
  if ($choice -eq 2) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Stop-vmhostservice}
  if ($choice -eq 3) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Start-vmhostservice | Set-VMHostService -Policy On}
  if ($choice -eq 4) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Stop-vmhostservice | Set-VMHostService -Policy off}  }
If (($option -EQ 'D') -or ($option -EQ 'd')) {  Write-Host "
  1. Turn On
  2. Turn Off
  3. Always On
  4. Always off
  "
  $choice  = read-host 'choose one of the above' -foregroundcolor green
  $service = ''
  if ($choice -eq 1) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Start-vmhostservice} 
  if ($choice -eq 2) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Stop-vmhostservice}
  if ($choice -eq 3) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Start-vmhostservice | Set-VMHostService -Policy On}
  if ($choice -eq 4) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Stop-vmhostservice | Set-VMHostService -Policy off}  }
If (($option -EQ 'E') -or ($option -EQ 'e')) {  Write-Host "
  1. Turn On
  2. Turn Off
  3. Always On
  4. Always off
  "
  $choice  = read-host 'choose one of the above' -foregroundcolor green
  $service = 'lbtd'
  if ($choice -eq 1) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Start-vmhostservice} 
  if ($choice -eq 2) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Stop-vmhostservice}
  if ($choice -eq 3) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Start-vmhostservice | Set-VMHostService -Policy On}
  if ($choice -eq 4) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Stop-vmhostservice | Set-VMHostService -Policy off}  }
If (($option -EQ 'F') -or ($option -EQ 'f')) {  Write-Host "
  1. Turn On
  2. Turn Off
  3. Always On
  4. Always off
  "
  $choice  = read-host 'choose one of the above' -foregroundcolor green
  $service = 'lwsmd'
  if ($choice -eq 1) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Start-vmhostservice} 
  if ($choice -eq 2) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Stop-vmhostservice}
  if ($choice -eq 3) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Start-vmhostservice | Set-VMHostService -Policy On}
  if ($choice -eq 4) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Stop-vmhostservice | Set-VMHostService -Policy off}  }
If (($option -EQ 'G') -or ($option -EQ 'g')) {  Write-Host "
  1. Turn On
  2. Turn Off
  3. Always On
  4. Always off
  "
  $choice  = read-host 'choose one of the above' -foregroundcolor green
  $service = 'ntpd'
  if ($choice -eq 1) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Start-vmhostservice} 
  if ($choice -eq 2) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Stop-vmhostservice}
  if ($choice -eq 3) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Start-vmhostservice | Set-VMHostService -Policy On}
  if ($choice -eq 4) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Stop-vmhostservice | Set-VMHostService -Policy off}  }
If (($option -EQ 'H') -or ($option -EQ 'h')) {  Write-Host "
  1. Turn On
  2. Turn Off
  3. Always On
  4. Always off
  "
  $choice  = read-host 'choose one of the above' -foregroundcolor green
  $service = 'pcscd'
  if ($choice -eq 1) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Start-vmhostservice} 
  if ($choice -eq 2) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Stop-vmhostservice}
  if ($choice -eq 3) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Start-vmhostservice | Set-VMHostService -Policy On}
  if ($choice -eq 4) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Stop-vmhostservice | Set-VMHostService -Policy off}  }
If (($option -EQ 'I') -or ($option -EQ 'i')) {  Write-Host "
  1. Turn On
  2. Turn Off
  3. Always On
  4. Always off
  "
  $choice  = read-host 'choose one of the above' -foregroundcolor green
  $service = 'sfcbd-watchdog'
  if ($choice -eq 1) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Start-vmhostservice} 
  if ($choice -eq 2) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Stop-vmhostservice}
  if ($choice -eq 3) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Start-vmhostservice | Set-VMHostService -Policy On}
  if ($choice -eq 4) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Stop-vmhostservice | Set-VMHostService -Policy off}  }
If (($option -EQ 'J') -or ($option -EQ 'j')) {  Write-Host "
  1. Turn On
  2. Turn Off
  3. Always On
  4. Always off
  "
  $choice  = read-host 'choose one of the above' -foregroundcolor green
  $service = 'snmpd'
  if ($choice -eq 1) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Start-vmhostservice} 
  if ($choice -eq 2) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Stop-vmhostservice}
  if ($choice -eq 3) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Start-vmhostservice | Set-VMHostService -Policy On}
  if ($choice -eq 4) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Stop-vmhostservice | Set-VMHostService -Policy off}  }
If (($option -EQ 'K') -or ($option -EQ 'k')) {  Write-Host "
  1. Turn On
  2. Turn Off
  3. Always On
  4. Always off
  "
  $choice  = read-host 'choose one of the above' -foregroundcolor green
  $service = 'vmsyslogd'
  if ($choice -eq 1) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Start-vmhostservice} 
  if ($choice -eq 2) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Stop-vmhostservice}
  if ($choice -eq 3) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Start-vmhostservice | Set-VMHostService -Policy On}
  if ($choice -eq 4) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Stop-vmhostservice | Set-VMHostService -Policy off}  }
If (($option -EQ 'L') -or ($option -EQ 'l')) {  Write-Host "
  1. Turn On
  2. Turn Off
  3. Always On
  4. Always off
  "
  $choice  = read-host 'choose one of the above' -foregroundcolor green
  $service = 'vprobed'
  if ($choice -eq 1) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Start-vmhostservice} 
  if ($choice -eq 2) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Stop-vmhostservice}
  if ($choice -eq 3) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Start-vmhostservice | Set-VMHostService -Policy On}
  if ($choice -eq 4) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Stop-vmhostservice | Set-VMHostService -Policy off}  }
If (($option -EQ 'M') -or ($option -EQ 'm')) {  Write-Host "
  1. Turn On
  2. Turn Off
  3. Always On
  4. Always off
  "
  $choice  = read-host 'choose one of the above' -foregroundcolor green
  $service = 'vpxa'
  if ($choice -eq 1) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Start-vmhostservice} 
  if ($choice -eq 2) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Stop-vmhostservice}
  if ($choice -eq 3) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Start-vmhostservice | Set-VMHostService -Policy On}
  if ($choice -eq 4) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Stop-vmhostservice | Set-VMHostService -Policy off}  }
If (($option -EQ 'M') -or ($option -EQ 'm')) {  Write-Host "
  1. Turn On
  2. Turn Off
  3. Always On
  4. Always off
  "
  $choice  = read-host 'choose one of the above' -foregroundcolor green
  $service = 'xorg'
  if ($choice -eq 1) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Start-vmhostservice} 
  if ($choice -eq 2) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Stop-vmhostservice}
  if ($choice -eq 3) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Start-vmhostservice | Set-VMHostService -Policy On}
  if ($choice -eq 4) {get-cluster $cluster | get-vmhost | get-vmhostservice | where Key -EQ $service | Stop-vmhostservice | Set-VMHostService -Policy off}  }
}
#End of function
fun_services
#End of script
