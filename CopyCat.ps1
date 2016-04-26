<#
.SYNOPSIS
    Copy files to esxi host.
.DESCRIPTION
    This will connect to the esxi host. List all the datastores connected to it. let the user choose the datastore and sets that as the default datastore.
    If the specified source directory ofthe files doesnt exist then it will ask you for that path and use that to copy files to the datastore.
.NOTES
    File Name      : Copycat.ps1
    Author         : gajendra d ambi
    Date           : April 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#Start of Script
#parameters/variables
param (
$esxi       = $(Read-Host "Input Esxi Address"),
$esxi_user  = $(Read-Host "Input username"),
$esxi_pass  = $(Read-Host -asSecureString "Input password"),
$source_dir = "C:\Users\pulverine\documents",
$dest_dir   = $(Read-Host '"Input the Destination Directory(ex:-"/vmware/docs"')
)

#connect to the host
Connect-VIServer $esxi -User $esxi_user -Password $esxi_pass

#Let us choose a datastore to copy the files to...
$allds = (get-vmhost | get-datastore).Name | sort
$z = 0
foreach ($ds in $allds){
Write-Host "$z - $ds"
$z = $z+1
}
$choice   = Read-host "select a number from above"
$datastore = Get-datastore $allds[$choice]
Write-Host "you chose $datastore" -BackgroundColor Green -ForegroundColor White

#mount the chose datastore as the ps drive
New-PSDrive -Location $datastore -Name psdrive -PSProvider VimDatastore -Root "\"

#test the source path and if the path isn't right then ask for an alternative path
while ((test-path $source_dir) -eq $false)
{
write-host "$source_dir is an Invalid Path" -BackgroundColor Red -ForegroundColor White
$source_dir = Read-Host "Location of the source directory?"
If ((test-path $source_dir) -eq $true) 
 {
 Write-Host "$source_dir is a Valid Path" -BackgroundColor Green -ForegroundColor White
 }
}

#copy data from source directory to destination directory
Copy-DatastoreItem $source_dir psdrive:$dest_dir -recurse -force

#End of Script