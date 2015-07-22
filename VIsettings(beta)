<#
.SYNOPSIS
    configure settings for your datacenter as a whole or one setting at a time.
.DESCRIPTION
    A beta version of VI settings
.NOTES
    File Name      : VIsettings(beta).ps1
    Author         : gajendra d ambi
    Prerequisite   : Powercli 5.x, PowerShell V2 over Vista and upper.
    Copyright      - None
.LINK
    Script posted over:
    https://github.com/gajuambi/vmware
#>

Read-Host "This is made to work best with targets which can be DNS resolved from 
where the script is being run, Hit Return/Enter to proceed"

#Disconnect any other hosts or vcenters if they are already connected.
Write-Host "Let us disconnect any other ESXi hosts or vcenters if they are connected"
Disconnect-VIServer *

#connect to the host or vcenter server
Write-Host "Let us connect to the target host or vCenter"
connect-viserver


#variables
$VMHosts = Get-VMHost | sort
$Syslogs = ""
$ntp1 = ""
$ntp2 = ""
$dns1 = ""
$dns2 = ""
$domain_name = ""
$communities = ""
$snmplocation = ""
$DumpTarget = ""

#constant values
$TcpipHeapSize = ""
$TcpipHeapMax = ""
$MaxVolumes = ""
$HeartbeatFrequency = ""
$HeartbeatTimeout = ""
$HeartbeatDelta = ""
$HeartbeatMaxFailures = ""

#start syslog function
Function Fun_syslog {
get-vmhost | Get-AdvancedSetting -Name Syslog.loggers.hostd.rotate | Set-AdvancedSetting -Value 80 -Confirm:$false
get-vmhost | Get-AdvancedSetting -Name Syslog.loggers.hostd.size | Set-AdvancedSetting -Value 10240 -Confirm:$false
get-vmhost | Get-AdvancedSetting -Name Syslog.loggers.vmkernel.rotate | Set-AdvancedSetting -Value 80 -Confirm:$false
get-vmhost | Get-AdvancedSetting -Name Syslog.loggers.vmkernel.size | Set-AdvancedSetting -Value 10240 -Confirm:$false
get-vmhost | Get-AdvancedSetting -Name Syslog.loggers.fdm.rotate | Set-AdvancedSetting -Value 80 -Confirm:$false
get-vmhost | Get-AdvancedSetting -Name Syslog.loggers.vpxa.rotate | Set-AdvancedSetting -Value 20 -Confirm:$false
get-vmhost | Get-AdvancedSetting -Name Syslog.global.defaultRotate | Set-AdvancedSetting -Value 20 -Confirm:$false
get-vmhost | Get-AdvancedSetting -Name Syslog.global.defaultSize | Set-AdvancedSetting -Value 10240 -Confirm:$false
get-vmhost | Get-AdvancedSetting -Name Syslog.global.logHost | Set-AdvancedSetting -Value $Syslogs -Confirm:$false
get-vmhost | Get-VMHostFirewallException -Name "syslog" | Set-VMHostFirewallException -enabled:$true
} #end syslog function

#Start ntp function
Function Fun_ntp {
$ntp = $ntp1 , $ntp2
foreach ($VMHost in $VMHosts) {Add-VMHostNTPServer -NtpServer $ntp -VMHost $VMHost -Confirm:$false}
} #End ntp function

#start dns function
Function Fun_dns {
$dns = $dns1 ,$dns2
$VMHosts = get-vmhost | sort
foreach ($VMHost in $VMHosts) {Get-VMHostNetwork -VMHost $VMHost | Set-VMHostNetwork -DNSAddress $dns}
} #end dns function

#start domain_name function
Function Fun_domain_name {
get-vmhost | Get-VMHostNetwork | Set-VMHostNetwork -DomainName $domain_name
} #end domain_name function

#start firewall function
Function Fun_firewall {
foreach ($VMHost in $VMHosts) {
Get-VmhostFirewallException -VMhost $VMhost -Name "netDump" | Set-VMHostFirewallException -enabled:$true
Get-VmhostFirewallException -VMhost $VMhost -Name "syslog" | Set-VMHostFirewallException -enabled:$true
Get-VmhostFirewallException -VMhost $VMhost -Name "SSH Client" | Set-VMHostFirewallException -enabled:$true
Get-VmhostFirewallException -VMhost $VMhost -Name "NTP Client" | Set-VMHostFirewallException -enabled:$true
Get-VmhostFirewallException -VMhost $VMhost -Name "vCenter Update Manager" | Set-VMHostFirewallException -enabled:$true
}
} #end firewall function

#start VMSecurity function
Function Fun_VMSecurity {
$ExtraOptions = @{
#http://practical-admin.com/blog/powercli-update-vmx-configuration-parameters-in-mass/ 
    "isolation.tools.diskWiper.disable"="true";
    "isolation.tools.diskShrink.disable"="true";
	"RemoteDisplay.maxConnections"="1";
	"isolation.tools.copy.disable"="true";
	"isolation.tools.paste.disable"="true";
	"isolation.tools.setGUIOptions.enable"="false";
	"isolation.tools.dnd.disable"="true";
	"isolation.device.connectable.disable"="true";
	"isolation.device.edit.disable"="true";
	"vmci0.unrestricted"="false";
	"log.rotateSize"="1000000";
	"log.keepOld"="10";
	"tools.setInfo.sizeLimit"="1048576";
	"guest.command.enabled"="false";
	"tools.guestlib.enableHostInfo"="false";
	"isolation.tools.unity.push.update.disable"="true";
	"isolation.tools.ghi.launchmenu.change"="true";
	"isolation.tools.memSchedFakeSampleStats.disable"="true";
	"isolation.tools.getCreds.disable"="true";
	"floppyX.present"="false";
	"SerialX.present"="false";
	"parallelX.present"="false";
	"usb.present"="false";
	"ideX:Y.present"="false";
}
 
# build our configspec using the hashtable from above.
$vmConfigSpec = New-Object VMware.Vim.VirtualMachineConfigSpec
# note we have to call the GetEnumerator before we can iterate through
Foreach ($Option in $ExtraOptions.GetEnumerator()) {
    $OptionValue = New-Object VMware.Vim.optionvalue
    $OptionValue.Key = $Option.Key
    $OptionValue.Value = $Option.Value
    $vmConfigSpec.extraconfig += $OptionValue
}
# Get all vm's not including templates
$VMs = Get-View -ViewType VirtualMachine -Property Name -Filter @{"Config.Template"="false"}
 
# Apply the new virtual machine spec with security hardening parameters
foreach($vm in $vms){
    $vm.ReconfigVM_Task($vmConfigSpec)
    Write-Host "Security hardening for $VM is complete"
}
} #End VMSecurity function

#start SNMP function
Function Fun_SNMP {
$esxcli = Get-EsxCli
$esxcli.system.snmp.set($null,$communities,"true",$null,$null,$null,$null,$null,$null,$null,$null,$null,$snmplocation)
$esxcli.system.snmp.get()
} #end SNMP function

#Start CoreDump function
Function Fun_CoreDump {
Get-VMHost | Set-VMHostDumpCollector -HostVNic "vmk0" -NetworkServerIP $DumpTarget -NetworkServerPort 6500
} #end CoreDump function

#Start funcion TCP
Function Fun_TCP {
get-vmhost | Get-AdvancedSetting -Name Net.TcpipHeapSize | Set-AdvancedSetting -Value $TcpipHeapSize -Confirm:$false
get-vmhost | Get-AdvancedSetting -Name Net.TcpipHeapMax | Set-AdvancedSetting -Value $TcpipHeapMax -Confirm:$false
} #end function TCP

#Start funcion NFS
Function Fun_NFS {
get-vmhost | Get-AdvancedSetting -Name NFS.MaxVolumes | Set-AdvancedSetting -Value $MaxVolumes -Confirm:$false
get-vmhost | Get-AdvancedSetting -Name NFS.HeartbeatFrequency | Set-AdvancedSetting -Value $HeartbeatFrequency -Confirm:$false
get-vmhost | Get-AdvancedSetting -Name NFS.HeartbeatTimeout | Set-AdvancedSetting -Value $HeartbeatTimeout -Confirm:$false
get-vmhost | Get-AdvancedSetting -Name NFS.HeartbeatDelta | Set-AdvancedSetting -Value $HeartbeatDelta -Confirm:$false
get-vmhost | Get-AdvancedSetting -Name NFS.HeartbeatMaxFailures | Set-AdvancedSetting -Value $HeartbeatMaxFailures -Confirm:$false
} #end function NFS

#start function MOB
#This will not be run when you choose to run all the script. This has to be run separately (to avoid repeating this lengthy task)
Function Fun_MOB {
#Get Plink
Write-Host "This script works on targets if the name resolution works from the machine where the script is being run"
$PlinkLocation = $PSScriptRoot + "\Plink.exe"
If (-not (Test-Path $PlinkLocation)){
   Write-Host "Plink.exe not found, trying to download..."
   $WC = new-object net.webclient
   $WC.DownloadFile("http://the.earth.li/~sgtatham/putty/latest/x86/plink.exe",$PlinkLocation)
   If (-not (Test-Path $PlinkLocation)){
      Write-Host "Unable to download plink.exe, please download from the following URL and add it to the same folder as this script: http://the.earth.li/~sgtatham/putty/latest/x86/plink.exe"
      Exit
   } Else {
      $PlinkEXE = Get-ChildItem $PlinkLocation
      If ($PlinkEXE.Length -gt 0) {
         Write-Host "Plink.exe downloaded, continuing script"
      } Else {
         Write-Host "Unable to download plink.exe, please download from the following URL and add it to the same folder as this script: http://the.earth.li/~sgtatham/putty/latest/x86/plink.exe"
         Exit
      }
   }  
}


#If using in powershell then add snapins below
Add-PSSnapin VMware.VimAutomation.Core -ea "SilentlyContinue"

#Connect to the vcenter server
connect-viserver

#copy plink to c:\ for now
Copy-Item $PSScriptRoot\plink.exe C:\

#Variables
$pass = Read-Host "Type the esxi password"
$user = Read-Host "Type the esxi username which is usually root"
$VMHosts = Get-VMHost | sort

##create a shell script on the esxi host
#create a text file on the host with the script
$cmd0 = "echo 'vim-cmd proxysvc/remove_service */mob* *httpsWithRedirect*' >> /tmp/mob.txt"
$cmd1 = "sed -i 's/*/\""/g' /tmp/mob.txt"
#convert the text to a shell script by just renaming
$rename = "mv /tmp/mob.txt /tmp/mob.sh"
#make the shell script executibel
$chmod = "chmod +x /tmp/mob.sh"
#run the mob shell script
$mob = "/tmp/mob.sh"
#remove the shell script
$clean = "rm -rf /tmp/mob.sh"

#Enable SSH on all hosts
Get-VMHost | Get-VMHostService | where {$_.Key -eq "TSM-SSH"} | Start-VMHostService

ForEach ($VMHost in $VMHosts)
{
echo y | C:\plink.exe -ssh $user@$VMHost -pw $pass "exit"
C:\plink.exe -ssh -v -noagent $VMHost -l $user -pw $pass $cmd0
C:\plink.exe -ssh -v -noagent $VMHost -l $user -pw $pass $cmd1
C:\plink.exe -ssh -v -noagent $VMHost -l $user -pw $pass $rename
C:\plink.exe -ssh -v -noagent $VMHost -l $user -pw $pass $chmod
C:\plink.exe -ssh -v -noagent $VMHost -l $user -pw $pass $mob
C:\plink.exe -ssh -v -noagent $VMHost -l $user -pw $pass $clean
}

#Disable SSH on all hosts
Get-VMHost | Get-VMHostService | where {$_.Key -eq "TSM-SSH"} | Stop-VMHostService

#delete plink from c:\
Remove-Item C:\plink.exe

#mob script below
#vim-cmd proxysvc/remove_service "/mob" "httpsWithRedirect"
}#End function MOB

#start function scratch
Function Fun_Scratch {
$VMHosts = Get-VMHost | sort
foreach ($VMHost in $VMHosts) {
$datastore = Get-Datastore
$ds = $datastore[0]
$scratch = ".locker-" + $_.Name.Split('.')[0]
Set-Location -Path $ds.DatastoreBrowserPath
New-Item $scratch -ItemType directory
Set-VMHostAdvancedConfiguration -Name ScratchConfig.ConfiguredScratchLocation -Value ('/vmfs/volumes/' + $ds.Name + '/' + $scratch) -Confirm:$false
}
}#end function scratch

$Title = "Select Function" #menu adopted from daniel classon
$Message = "choose your funtion"

$all = New-Object System.Management.Automation.Host.ChoiceDescription "&all", ` "all"
$syslog = New-Object System.Management.Automation.Host.ChoiceDescription "&syslog", ` "syslog"
$ntp = New-Object System.Management.Automation.Host.ChoiceDescription "&ntp", ` "ntp"
$dns = New-Object System.Management.Automation.Host.ChoiceDescription "&dns", ` "dns"
$domain_name = New-Object System.Management.Automation.Host.ChoiceDescription "&domain_name", ` "domain_name"
$firewall = New-Object System.Management.Automation.Host.ChoiceDescription "&firewall", ` "firewall"
$VMSecurity = New-Object System.Management.Automation.Host.ChoiceDescription "&VMSecurity", ` "VMSecurity"
$SNMP = New-Object System.Management.Automation.Host.ChoiceDescription "&SNMP", ` "SNMP"
$CoreDump = New-Object System.Management.Automation.Host.ChoiceDescription "&CoreDump", ` "CoreDump"
$TCP = New-Object System.Management.Automation.Host.ChoiceDescription "&TCP", ` "TCP"
$NFS = New-Object System.Management.Automation.Host.ChoiceDescription "&NFS", ` "NFS"
$mob = New-Object System.Management.Automation.Host.ChoiceDescription "&mob", ` "mob"
$Scratch = New-Object System.Management.Automation.Host.ChoiceDescription "&Scratch", ` "Scratch"

####################################################################0#   #1#      #2#   #3#   #4#           #5#        #6#          #7#    #8#        #9#   #10#  #11#  #12#
$Options = [System.Management.Automation.Host.ChoiceDescription[]]($all, $syslog, $ntp, $dns, $domain_name, $firewall, $VMSecurity, $SNMP, $CoreDump, $TCP, $NFS, $mob, $Scratch)
$Select = $host.ui.PromptForChoice($title, $message, $options, 0)
 
     switch($Select)
    {
        0 {
		   {Fun_syslog}
		   {Fun_ntp}
		   {Fun_dns}
		   {Fun_domain_name}
		   {Fun_VMSecurity}
		   {Fun_SNMP}
		   {Fun_CoreDump}
		   {Fun_TCP}
		   {Fun_NFS}
           {Fun_Scratch}
		                }
        1 {Fun_syslog}
        2 {Fun_ntp}
        3 {Fun_dns}
        4 {Fun_domain_name}
        5 {Fun_firewall}
        6 {Fun_VMSecurity}
        7 {Fun_SNMP}
        8 {Fun_CoreDump}
        9 {Fun_TCP}
        10 {Fun_NFS}
        11 {Fun_MOB}
		12 {Fun_Scratch}
    }
