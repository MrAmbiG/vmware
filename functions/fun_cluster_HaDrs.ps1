<#
.SYNOPSIS
    configure HA & DRS
.DESCRIPTION
    This will configure HA & DRS on your cluster or cluster.
    It will disable admission control on your cluster if the cluster has 3 or less than 3 hosts.
    It will enable the DRS, set the automation level to fully automatic
.NOTES
    File Name      : fun_cluster_HaDrs.ps1
    Author         : gajendra d ambi
    Date           : January 2016
    recommended    : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware   
#>

#start of script
#start of function
Function fun_cluster_HaDrs {
$cluster = Read-Host "name of the cluster?:"
get-cluster -Name $cluster | Set-Cluster -HAEnabled:$true -DRSEnabled:$true -DRSAutomationLevel "FullyAutomated" -Confirm:$false
  if ((get-cluster -Name $cluster | get-vmhost).count -lt 4) {
  Set-Cluster -Name $cluster -HAAdmissionControlEnabled:$true
 }
}
#End of function
fun_cluster_HaDrs
#End of script
