
<#
.SYNOPSIS
    CIMCaudit1.0.2
.DESCRIPTION
    This will log into the Cisco IMC and pull the details and generate an html report.
    It does not make any changes but reports the requested facts of the CIMC.
.NOTES
    File Name      : CIMCaudit.ps1
    Author         : gajendra d ambi
    Date           : July 2015
    Prerequisite   : PowerShell V2+, powertool 1+ over Vista and upper.
    Copyright      - None
    ver 1.0.1      : Hostname; ExtGw; ExtIp; ExtMask;PCI ROM IP Blocking; admin state of ssh,http,https; kvm; vMedia; boot & running firmware; date & time; BIOS version 
    ver 1.0.2      : using Get-ImcSyslog instead of Get-ImcSyslogclient to get complete syslog information, ipmi, adjacent cache line prefetch, DCU Prefetch,DirectCacheAccess, CPU Power Management,Intel Enhanced Speedstep Tech, LOM
.LINK
    Script posted over:
    http://ambitech.blogspot.in/2015/07/cisco-imb-cimc-reporting.html
#>

#style, table and some background color
$a = "<style>"
$a = $a + "BODY{background-color:DarkGray;}"
$a = $a + "TABLE{border-width: 5px;border-style: solid;border-color: Purple;border-collapse: collapse;}"
$a = $a + "TH{border-width: 1px;padding: 0px;border-style: solid;border-color: black;background-color:LightSeaGreen}"
$a = $a + "TD{border-width: 1px;padding: 0px;border-style: solid;border-color: black;background-color:WhiteSmoke}"
$a = $a + "</style>"

#define temporary file path
$path = "C:\"

#Disconnect from any existing CIMC if any
Disconnect-Imc

#let us make powertool to accept multiple default connections to imc to avoid any errors related to it
#Set-ImcPowerToolConfiguration -SupportMultipleDefaultImc $true

#CIMC
$cimc = Read-Host "CIMC target?"

#connect to the cisco IMC
#Connect-Imc -NotDefault $cimc
Connect-Imc $cimc

#Inform the user that the script is running since there will be no output on the screen
Write-Host "Please wait, the Cisco IMC Audit report is being generated....This will take less than a minute..."

#CIMC MainInfo
$imcinfo = Get-ImcStatus
$imc = $imcinfo | Select-Object Name, Model, ProductName, Serial, Vendor, VirtualIpv4Address, BiosVersion, DhcpEnable, DnsAlternate, DnsPreferred, DnsUsingDhcp, ExtGateway, ExtIp, ExtMask, FirmwareVersion, MacAddress, Mode | ConvertTo-HTML -Fragment -PreContent '<p4> <font face="Algerian" size="9" color="navy"><p align="center"><u><b>CISCO IMC[CIMC] AUDIT REPORT</b></u></font> </p4><p>      </p> <p3> <font color="#1A1B1C"><b>CIMC Main Info<b></font> </p3>' | Out-String

##Firmware
#Running Firmware
$rfirminfo = Get-ImcFirmwareRunning
$rfirm = $rfirminfo | Select-Object Imc, Description, Type, Version | ConvertTo-HTML -Fragment -PreContent '<p>      </p><p3> <font color="#1A1B1C"><b>Running Firmware<b></font> </p3>' | Out-String

#Boot Firmware
$bfirminfo = Get-ImcFirmwareRunning
$bfirm = $bfirminfo | Select-Object Imc, Description, Type, Version | ConvertTo-HTML -Fragment -PreContent '<p>      </p><p3> <font color="#1A1B1C"><b>Boot Firmware<b></font> </p3>' | Out-String

#Network
$network = Get-ImcMgmtIf
$nw = $network | Select-Object Imc, Hostname, DdnsDomain, NicMode, NicRedundancy | ConvertTo-HTML -Fragment -PreContent '<p>      </p><p3> <font color="#1A1B1C"><b>Network<b></font> </p3>' | Out-String

#IP Blocking
$ipblockinfo = Get-ImcIpBlocking
$block = $ipblockinfo | Select-Object Imc, Enable, Rn | ConvertTo-HTML -Fragment -PreContent '<p>      </p><p3> <font color="#1A1B1C"><b>IP Blocking<b></font> </p3>' | Out-String

#Syslog
$syslog = Get-ImcSyslog
$sys = $syslog | Select-Object Imc, Name, Descr, LocalSeverity, RemoteSeverity, Port, Proto | ConvertTo-HTML -Fragment -PreContent '<p>      </p><p3> <font color="#1A1B1C"><b>Syslog<b></font> </p3>' | Out-String

#NTP
$ntpinfo = Get-ImcNtpServer
$ntp = $ntpinfo | Select-Object Imc, NtpServer1, NtpServer2, NtpServer3 | ConvertTo-HTML -Fragment -PreContent '<p>      </p><p3> <font color="#1A1B1C"><b>NTP<b></font> </p3>' | Out-String

#SNMP
$snmpinfo = Get-ImcSnmp
$snmp = $snmpinfo | Select-Object Imc, Descr, AdminState, Com2Sec, Community, Port, SysContact, SysLocation, TrapCommunity | ConvertTo-HTML -Fragment -PreContent '<p>      </p><p3> <font color="#1A1B1C"><b>SNMP<b></font> </p3>' | Out-String

##ACCESS
#ssh
$sshinfo = Get-ImcSsh
$ssh = $sshinfo | Select-Object Imc, Name, Descr, Proto, Port, AdminState | ConvertTo-HTML -Fragment -PreContent '<p>      </p><p3> <font color="#1A1B1C"><b>SSH<b></font> </p3>' | Out-String
#http
$httpinfo = Get-ImcHttp
$http = $httpinfo | Select-Object Imc, Name, Descr, Proto, Port, AdminState | ConvertTo-HTML -Fragment -PreContent '<p>      </p><p3> <font color="#1A1B1C"><b>HTTP<b></font> </p3>' | Out-String
#https
$httpsinfo = Get-ImcHttps
$https = $httpsinfo |  Select-Object Imc, Name, Descr, Proto, Port, AdminState | ConvertTo-HTML -Fragment -PreContent '<p>      </p><p3> <font color="#1A1B1C"><b>HTTPS<b></font> </p3>' | Out-String
#Ipmi
$ipmiinfo = Get-ImcCommIpmiLan
$ipmi = $ipmiinfo | Select-Object Imc, Rn, AdminState | ConvertTo-HTML -Fragment -PreContent '<p>      </p> <p3> <font color="#1A1B1C"><b>Ipmi<b></font> </p3>' | Out-String
#KVM
$kvminfo = ImcCommKvm
$kvm = $kvminfo | Select-Object Imc, Rn, AdminState, EncryptionState, LocalVideoState, Port, ActiveSessions, TotalSessions | ConvertTo-HTML -Fragment -PreContent '<p>      </p> <p3> <font color="#1A1B1C"><b>Kvm<b></font> </p3>' | Out-String
#vMedia
$vmediainfo = ImcCommVMedia
$vmedia = $vmediainfo | Select-Object Imc, Rn, AdminState, EncryptionState | ConvertTo-HTML -Fragment -PreContent '<p>      </p> <p3> <font color="#1A1B1C"><b>Virtual Media<b></font> </p3>' | Out-String

##boot
#1st
$bootsdinfo = Get-ImcLsbootSd
$bootsd = $bootsdinfo | Select-Object Imc, Order, Type, Name, State  | ConvertTo-HTML -Fragment -PreContent '<p>      </p></p> <p3> <font color="#1A1B1C"><b>Boot from SD<b></font> </p3>' | Out-String
#2nd
$bootvminfo = Get-ImcLsbootVMedia
$bootvm = $bootvminfo | Select-Object Imc, Order, Type, Name, State  | ConvertTo-HTML -Fragment -PreContent '<p>      </p></p> <p3> <font color="#1A1B1C"><b>Boot from vMedia<b></font> </p3>' | Out-String
#3rd
$bootPxeinfo = Get-ImcLsbootPxe
$bootPxe = $bootPxeinfo | Select-Object Imc, Order, Type, Name, State  | ConvertTo-HTML -Fragment -PreContent '<p>      </p></p> <p3> <font color="#1A1B1C"><b>Boot from PXE<b></font> </p3>' | Out-String
#4th
$bootuefioinfo = Get-ImcLsbootUefiShell
$bootuefio = $bootuefioinfo | Select-Object Imc, Order, Type, Name, State  | ConvertTo-HTML -Fragment -PreContent '<p>      </p></p> <p3> <font color="#1A1B1C"><b>Boot from UEFI<b></font> </p3>' | Out-String

##BIOS
#CPU Configuration
#CPU information
$cpuinfo = Get-ImcProcessorUnit
$cpu = $cpuinfo | Select-Object Imc, SocketDesignation, Rn, Dn, Vendor, Arch, Cores, CoresEnabled, Id, Model, OperState, Presence, Speed, Stepping, Threads  | ConvertTo-HTML -Fragment -PreContent '<p>      </p></p> <p3> <font color="#1A1B1C"><b>CPU Main Info<b></font> </p3>' | Out-String
 #Intel VT
 $IntVttinfo = Get-ImcBiosVfIntelVirtualizationTechnology
 $IntVtt = $IntVttinfo | Select-Object Imc, VpIntelVirtualizationTechnology, Rn | ConvertTo-HTML -Fragment -PreContent '<p>      </p></p> <p3> <font color="#1A1B1C"><b>Intel VT<b></font> </p3>' | Out-String
 #Intel VT DirectIO
 $IntVtIOinfo = Get-ImcBiosIntelDirectedIO
 $IntVtIO = $IntVtIOinfo | Select-Object Imc, VpIntelVTForDirectedIO, Rn  | ConvertTo-HTML -Fragment -PreContent '<p>      </p></p> <p3> <font color="#1A1B1C"><b>Intel VT Directed IO<b></font> </p3>' | Out-String
 #Intel HT
 $htinfo = Get-ImcBiosHyperThreading
 $ht = $htinfo | Select-Object Imc, VpIntelHyperThreadingTech, Rn  | ConvertTo-HTML -Fragment -PreContent '<p>      </p></p> <p3> <font color="#1A1B1C"><b>Intel HT<b></font> </p3>' | Out-String
 #Execution Disable Bit
 $exdisbitinfo = Get-ImcBiosExecuteDisabledBit
 $exdisbit = $exdisbitinfo | Select-Object Imc, VpExecuteDisableBit, Rn | ConvertTo-HTML -Fragment -PreContent '<p>      </p></p> <p3> <font color="#1A1B1C"><b>Intel HT<b></font> </p3>' | Out-String
 #Hardware Prefetch
 $vfhpinfo = Get-ImcBiosVfHardwarePrefetch
 $vfhp = $vfhpinfo | Select-Object Imc, VpHardwarePrefetch, Rn | ConvertTo-HTML -Fragment -PreContent '<p>      </p></p> <p3> <font color="#1A1B1C"><b>Intel Hardware Prefetch<b></font> </p3>' | Out-String
 #adjacent cache line prefetch
 $aclpinfo = ImcBiosVfAdjacentCacheLinePrefetch
 $aclp = $aclpinfo | Select-Object Imc, VpAdjacentCacheLinePrefetch, Rn | ConvertTo-HTML -Fragment -PreContent '<p>      </p></p> <p3> <font color="#1A1B1C"><b>Adjacent Cache Line Prefetch<b></font> </p3>' | Out-String
 #DCU prefetch
 $dcupinfo = Get-ImcBiosVfDCUPrefetch
 $dcup = $dcupinfo | Select-Object Imc, VpIPPrefetch, VpStreamerPrefetch, Rn | ConvertTo-HTML -Fragment -PreContent '<p>      </p><p3> <font color="#1A1B1C"><b>DCU Prefetch<b></font> </p3>' | Out-String
 #Direct Cache Access
 $dcainfo = Get-ImcBiosVfDirectCacheAccess
 $dca = $dcainfo | Select-Object Imc, VpDirectCacheAccess, Rn | ConvertTo-HTML -Fragment -PreContent '<p>      </p><p3> <font color="#1A1B1C"><b>Direct Cache Access<b></font> </p3>' | Out-String
 #CPU Power Management
 $cpupminfo = Get-ImcBiosVfCPUPowerManagement
 $cpupm = $cpupminfo | Select-Object Imc, VpDirectCacheAccess, Rn | ConvertTo-HTML -Fragment -PreContent '<p>      </p><p3> <font color="#1A1B1C"><b>CPU Power Management<b></font> </p3>' | Out-String
 #Enhanced Speed step Technology
 $cpupminfo = Get-ImcBiosEnhancedIntelSpeedStep
 $cpupm = $cpupminfo | Select-Object Imc, VpEnhancedIntelSpeedStepTech, Rn | ConvertTo-HTML -Fragment -PreContent '<p>      </p><p3> <font color="#1A1B1C"><b>Enhanced Speed step Technology<b></font> </p3>' | Out-String
 #Intel Turbo Boost Technology
 $tbinfo = Get-ImcBiosTurboBoost
 $tb = $tbinfo | Select-Object Imc, VpIntelTurboBoostTech, Rn | ConvertTo-HTML -Fragment -PreContent '<p>      </p><p3> <font color="#1A1B1C"><b>Intel Turbo Boost Technology<b></font> </p3>' | Out-String
 #CPU Frequency Floor
 $vcpuffinfo = Get-ImcBiosVfCPUFrequencyFloor
 $vcpuff = $vcpuffinfo | Select-Object Imc, VpCPUFrequencyFloor, Rn | ConvertTo-HTML -Fragment -PreContent '<p>      </p></p> <p3> <font color="#1A1B1C"><b>CPU Frequency Floor Setting<b></font> </p3>' | Out-String
 #CPU C1 state
 $vpc1einfo = Get-ImcBiosVfProcessorC1E
 $vpc1e =  $vpc1einfo | Select-Object Imc, VpProcessorC1E, Rn | ConvertTo-HTML -Fragment -PreContent '<p>      </p></p> <p3> <font color="#1A1B1C"><b>C1 Powerstate<b></font> </p3>' | Out-String
 #CPU C6 state
 $vpc6rinfo = Get-ImcBiosVfProcessorC6Report
 $vpc6r =  $vpc6rinfo | Select-Object Imc, VpProcessorC6Report, Rn | ConvertTo-HTML -Fragment -PreContent '<p>      </p></p> <p3> <font color="#1A1B1C"><b>CPU C6 State<b></font> </p3>' | Out-String
 #CPU Enrgy Settings
 $vcpuepinfo = Get-ImcBiosVfCPUEnergyPerformance
 $vcpuep = $vcpuepinfo | Select-Object Imc, VpCPUEnergyPerformance, Rn | ConvertTo-HTML -Fragment -PreContent '<p>      </p></p> <p3> <font color="#1A1B1C"><b>CPU Energy Setting<b></font> </p3>' | Out-String
 #CPU Multi Core Setting
 $vcmpinfo = Get-ImcBiosVfCoreMultiProcessing
 $vcmp =  $vcmpinfo | Select-Object Imc, VpCoreMultiProcessing, Rn | ConvertTo-HTML -Fragment -PreContent '<p>      </p></p> <p3> <font color="#1A1B1C"><b>Multi Core Processing<b></font> </p3>' | Out-String

 #Memory Configuration
 #LV DDR mode
 $lvdminfo = Get-ImcBiosLvDdrMode
 $lvdm = $lvdminfo | Select-Object Imc, VpIntelTurboBoostTech, Rn | ConvertTo-HTML -Fragment -PreContent '<p>      </p><p3> <font color="#1A1B1C"><b>LV DDR mode<b></font> </p3>' | Out-String
 $vdramctinfo = Get-ImcBiosVfDRAMClockThrottling
 $vdramct = $vdramctinfo | Select-Object Imc, VpDRAMClockThrottling, Rn | ConvertTo-HTML -Fragment -PreContent '<p>      </p></p> <p3> <font color="#1A1B1C"><b>DRAM Clock Throttling<b></font> </p3>' | Out-String
 $numainfo = Get-ImcBiosNUMA
 $numa =  $numainfo | Select-Object Imc, VpNUMAOptimized, Rn | ConvertTo-HTML -Fragment -PreContent '<p>      </p></p> <p3> <font color="#1A1B1C"><b>NUMA Status<b></font> </p3>' | Out-String
 $vdrrinfo = Get-ImcBiosVfDramRefreshRate
 $vdrr =  $vdrrinfo | Select-Object Imc, VpDramRefreshRate, Rn | ConvertTo-HTML -Fragment -PreContent '<p>      </p></p> <p3> <font color="#1A1B1C"><b>Memory Refersh Rate<b></font> </p3>' | Out-String
 $vmiinfo = Get-ImcBiosVfMemoryInterleave
 $vmi =  $vmiinfo | Select-Object Imc, VpChannelInterLeave, Rn | ConvertTo-HTML -Fragment -PreContent '<p>      </p></p> <p3> <font color="#1A1B1C"><b>Memory Channel Interleave<b></font> </p3>' | Out-String
 #Memory Patrol Scrub
 $vpsinfo = Get-ImcBiosVfPatrolScrub
 $vps =  $vpsinfo | Select-Object Imc, VpPatrolScrub, Rn | ConvertTo-HTML -Fragment -PreContent '<p>      </p></p> <p3> <font color="#1A1B1C"><b>Memory Scrubbing<b></font> </p3>' | Out-String
 #Memory Demand Scrub
 $vpsinfo = Get-ImcBiosVfDemandScrub
 $vps =  $vpsinfo | Select-Object Imc, VpDemandScrub, Rn | ConvertTo-HTML -Fragment -PreContent '<p>      </p></p> <p3> <font color="#1A1B1C"><b>Memory Demand Scrub<b></font> </p3>' | Out-String
 #VF Altitude
 $vfainfo = Get-ImcBiosVfAltitude
 $vfa =  $vfainfo | Select-Object Imc, VpAltitude, Rn | ConvertTo-HTML -Fragment -PreContent '<p>      </p></p> <p3> <font color="#1A1B1C"><b>VF Altitude<b></font> </p3>' | Out-String
 $vsmrascinfo = Get-ImcBiosVfSelectMemoryRASConfiguration
 $vsmrasc =  $vsmrascinfo | Select-Object Imc, VpSelectMemoryRASConfiguration, Rn | ConvertTo-HTML -Fragment -PreContent '<p>      </p></p> <p3> <font color="#1A1B1C"><b>Memory RAS<b></font> </p3>' | Out-String

 #LOM Port Settings
 $lominfo = Get-ImcBiosVfLOMPortOptionROM
 $lom =  $lominfo | Select-Object Imc, VpLOMPortsAllState, VpLOMPort0State, VpLOMPort1State, Rn | ConvertTo-HTML -Fragment -PreContent '<p>      </p></p> <p3> <font color="#1A1B1C"><b>VF Altitude<b></font> </p3>' | Out-String


 #PCI ROM info
 $pcirominfo = ImcBiosVfPCISlotOptionROMEnable
 $pcirom = $pcirominfo | Select-Object Imc, Rn, VpSlot1State, VpSlot2State, VpSlot3State, VpSlot4State, VpSlot5State, VpSlot6State, VpSlot7State, VpSlot8State, VpSlot8State, VpSlot10State, VpSlotMezzState | ConvertTo-HTML -Fragment -PreContent '</p> <p3> <font color="#1A1B1C"><b>LOM Port Settings<b></font> </p3>' | Out-String
 
 #PCI
 $pciinfo = Get-ImcPciEquipSlot
 $pci = $pciinfo | Select-Object Imc, Model, Rn | ConvertTo-HTML -Fragment -PreContent '<p>      </p><p3> <font color="#1A1B1C"><b>PCI info<b></font> </p3>' | Out-String
 
 #PSU(power supply)
 $psuinfo = Get-ImcPsu
 $psu = $psuinfo | Select-Object Imc, FwVersion, Id, Input, Model, Operability, Power, presence, Serial, Thermal, Rn, Vendor | ConvertTo-HTML -Fragment -PreContent '<p>      </p><p3> <font color="#1A1B1C"><b>PSU info<b></font> </p3>' | Out-String

 #USB Configuration
 $vlusbsinfo = Get-ImcBiosVfLegacyUSBSupport
 $vlusbs = $vlusbsinfo | Select-Object Imc, VpLegacyUSBSupport, Rn | ConvertTo-HTML -Fragment -PreContent '<p>      </p></p> <p3> <font color="#1A1B1C"><b>USB Legacy Support<b></font> </p3>' | Out-String
 $vusbeinfo = Get-ImcBiosVfUSBEmulation
 $vusbe =  $vusbeinfo | Select-Object Imc, VpUSBEmul6064, Rn | ConvertTo-HTML -Fragment -PreContent '<p>      </p></p> <p3> <font color="#1A1B1C"><b>USB Emulation<b></font> </p3>' | Out-String
 $vusbpcinfo = Get-ImcBiosVfUSBPortsConfig
 $vusbpc = $vusbpcinfo | Select-Object Imc, VpAllUsbDevices, Rn | ConvertTo-HTML -Fragment -PreContent '<p>      </p></p> <p3> <font color="#1A1B1C"><b>USB Devices<b></font> </p3>' -PostContent '<p>      </p></p> <p3> <font color="#1A1B1C"><b>END OF REPORT<b></font> </p3>'| Out-String

#merge all fragments into one html
ConvertTo-HTML -head $a -body "$imc $nw $block $rfirm $bfirm $sys $ntp $snmp $ssh $http $https $ipmi $kvm $vmedia $bootsd $bootvm $bootPxe $bootuefio $cpu $IntVtt $IntVtIO $ht $exdisbit $vfhp $aclp $dcup $dca $cpupm $tb $vcpuff $vpc1e $vpc6r $vcpuep $vcmp $lvdm $vdramct $numa $vdrr $vmi $vps $vsmrasc $lom $pcirom $pci $psu $vlusbs $vusbe $vusbpc" | Out-File $path\cimc.html

#move the .html file from C drive to the location of the script that you are running
mi $path\cimc.html $PSScriptRoot -force

#let us open the above report in a default browser
ii $PSScriptRoot\cimc.html

#let us default powertool to reject multiple default connections to imc to avoid any errors related to it
#Set-ImcPowerToolConfiguration -SupportMultipleDefaultImc $false

#Disconnect from Cisco IMC
Disconnect-Imc

#End of Script
