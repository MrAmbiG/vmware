#vaai 1.0
#compiled by: MrAmbig
#Script Type:Powercli 5.5+(using advanced setting cmdlts instead of vmhostadvancedconfiguration except the firewall setting)
#Description-set syslog servers and set syslog settings.
#ambitech.blogspot.in/2015/04/set-multiple-syslog-servers-on-multiple.html?
########################################################
#connect to vcenter
connect-viserver

Get-AdvancedSetting -Entity (Get-VMHost) –Name VMFS3.HardwareAcceleratedLocking | Set-AdvancedSetting –Value 1
Get-AdvancedSetting -Entity (Get-VMHost) –Name DataMover.HardwareAcceleratedMove | Set-AdvancedSetting –Value 1
Get-AdvancedSetting -Entity (Get-VMHost) –Name DataMover.HardwareAcceleratedInit | Set-AdvancedSetting –Value 1
