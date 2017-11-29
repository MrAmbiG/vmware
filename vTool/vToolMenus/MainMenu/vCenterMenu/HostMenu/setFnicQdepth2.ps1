function setFnicQdepth2 {
<#
.SYNOPSIS
    configure max q depth value for fnic
.DESCRIPTION
    this will set a max q depth value for fnic on esxi hosts.
    it asks for the cluster's name and qdepth value to be set.
.NOTES
    File Name      : setFnicQdepth.ps1
    Author         : gajendra d ambi
    Date           : oct 2017
    Prerequisite   : PowerShell v4+, powercli 6.3+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/MrAmbiG/vmware
#>
#Start of Script
$cluster = Read-Host "name of the cluster?"
$qdepth = Read-Host "Q depth value?"
$vmhosts = Get-Cluster $cluster | get-vmhost
write-host"
1.qla2xxx - QLogic
2.qlnativefc - QLogic native drivers
3.lpfc820 - Emulex
4.lpfc - Emulex native drivers
5.bfa - Brocade

reference : https://docs.vmware.com/en/VMware-vSphere/6.5/com.vmware.vsphere.troubleshooting.doc/GUID-9A0D1A30-D931-4914-8B06-8C13FB553EF3.html
"
$choise = Read-Host 'choose from 1 to 4'
if ($choise -eq 1) {$module = "qla2xxx"; $qdepth ="ql2xmaxqdepth=$qdepth" }
if ($choise -eq 2) {$module = "qlnativefc"; $qdepth ="ql2xmaxqdepth=$qdepth" }
if ($choise -eq 3) {$module = "lpfc820"; $qdepth ="lpfc0_lun_queue_depth=$qdepth" }
if ($choise -eq 4) {$module = "lpfc"; $qdepth ="lpfc0_lun_queue_depth=$qdepth" }
if ($choise -eq 5) {$module = "bfa"; $qdepth ="bfa_lun_queue_depth=$qdepth" }

foreach ($vmhost in $vmhosts) {
$esxcli = get-vmhost $vmhost | get-esxcli -v2
$esxcliset = $esxcli.system.module.parameters.set
$args = $esxcliset.CreateArgs()
$args.module = $module
$args.parameterstring = "$qdepth"
$esxcliset.Invoke($args) 
} }