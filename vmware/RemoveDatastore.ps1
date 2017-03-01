<#
.SYNOPSIS
    Remove datastores of hosts
.DESCRIPTION
    Removes datastores of all the hosts of a cluster
.NOTES
    File Name      : RemoveDatastore.ps1
    Author         : gajendra d ambi
    Date           : May 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    github.com/mrambig
#>

$cluster = Read-Host "Name of the Cluster?"
$vmhosts = get-cluster $cluster | get-vmhost | sort
foreach ($vmhost in $vmhosts)
{
 $datastores = $vmhost | get-datastore
 foreach ($datastore in $datastores) 
 {
  if ($datastore.Name -match "XIO_Datastore")
  {
   Remove-Datastore -Datastore $datastore -VMHost $vmhost -Confirm:$false
  }  
 }
}