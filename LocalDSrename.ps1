<#
.SYNOPSIS
    LocalDSrename
.DESCRIPTION
    Rename the local datastore as hosts's shortname-Local that is host-Local
.NOTES
    File Name      : LocalDSrename.ps1
    Author         : gajendra d ambi
    Date           : 
    Prerequisite   : PowerShell V3, powercli 5+ over Vista and upper.
    Copyright      - None
.LINK
    Script posted over:
    http://www.pcli.me/?p=25
    http://ambitech.blogspot.in/2015/08/rename-those-ugly-esxi-local-datastores.html
#>

#If using in powershell then add snapins below
Add-PSSnapin VMware.VimAutomation.Core -ErrorAction SilentlyContinue

#Disconnect from already connected viservers if any
Disconnect-VIServer * -ErrorAction SilentlyContinue

#Connect to the VIserver
Connect-VIServer

#replace * with the name of the cluster if you want to perform it for a particular cluster
$VMHosts = get-cluster * | get-vmhost | %{$_.name}
foreach($VMHost in $VMHosts){
$hostname = $VMHost.split(“.”)
$host = $hostname[0]
$DSname = $host+"-Local"
get-vmhost $VMHost | get-datastore | where {$_.name -match "datastore1"} | set-datastore -name $DSname
}
