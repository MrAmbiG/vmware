function setFnicQdepth {
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

foreach ($vmhost in $vmhosts) {
$esxcli = get-vmhost $vmhost | get-esxcli -v2
$esxcliset = $esxcli.system.module.parameters.set
$args = $esxcliset.CreateArgs()
$args.module = "qla2xxx"
$args.parameterstring = "$qdepth"
$esxcliset.Invoke($args) 
} }

