<#
.SYNOPSIS
    create a new cluster.
.DESCRIPTION
    This will create a new cluster for the default datacenter. if there is more than one datacenter then it will ask you for which datacenter you want to create the cluster.
.NOTES
    File Name      : fun_create_cluster.ps1
    Author         : gajendra d ambi
    Date           : January 2016
    recommended    : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware   
#>

#start of script
#start of function
Function fun_create_cluster {
$cluster = Read-Host "name of the cluster?"
  if ((Get-Datacenter).count -gt 1) {
  $dc    = Read-Host "name of the datacenter?"
 }
 Get-Datacenter -Name $dc | New-Cluster -Name $cluster -Confirm:$false
}
#End of function
fun_create_cluster
#End of script
