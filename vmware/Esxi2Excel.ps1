<#
.SYNOPSIS
    Export data of esxi to excel

.DESCRIPTION
    Fetch fqdn, cpu details, serial number and local disk information of the esxi host.

.NOTES
    File Name      : Esxi2Xcel.ps1
    Author         : gajendra d ambi
    Date           : Oct 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/mrambig
#>

#start of script
Connect-VIServer

#start defining excel
$xlXLS   = 56
$xlsfile = "$psscriptroot\EsxiInfo.xls"

$Excel = New-Object -ComObject Excel.Application
$Excel.visible = $True
$Excel = $Excel.Workbooks.Add()

$Sheet = $Excel.Worksheets.Item(1)
$Sheet.Cells.Item(1,1) = "FQDN"
$Sheet.Cells.Item(1,2) = "CPU Type"
$Sheet.Cells.Item(1,3) = "Model"
$Sheet.Cells.Item(1,4) = "Make"
$Sheet.Cells.Item(1,5) = "NumCPU"
$Sheet.Cells.Item(1,6) = "SN"
$Sheet.Cells.Item(1,7) = "Disks(MB)"

[int]$intRow = 2

$WorkBook = $Sheet.UsedRange
$WorkBook.Interior.ColorIndex = 17
$WorkBook.Font.ColorIndex = 1
$WorkBook.Font.Bold = $True
#end defining excel

#esxi host info
$cluster = '*'
$vmhosts = get-cluster $cluster | get-vmhost | sort
$vmhosts = $vmhosts

foreach ($vmhost in $vmhosts)
{
$a      = get-vmhost $vmhost
$fqdn   = $a.name
$cpu    = $a.ProcessorType
$model  = $a.Model
$make   = $a.Manufacturer
$NumCpu = $a.ExtensionData.Hardware.CpuInfo.NumCpuPackages
$sn     = ($a.ExtensionData.Summary.Hardware.OtherIdentifyingInfo.IdentifierValue)[2]
$disks  = ($vmhost | get-vmhostdisk | Where-Object { $_.DeviceName -Match 'mpx' } ).ExtensionData.layout.Total.Block
$disks  = $disks -join ','

$Sheet.Cells.Item($intRow, 1) = $fqdn
$Sheet.Cells.Item($intRow, 2) = $cpu
$Sheet.Cells.Item($intRow, 3) = $model
$Sheet.Cells.Item($intRow, 4) = $make
$Sheet.Cells.Item($intRow, 5) = $NumCpu
$Sheet.Cells.Item($intRow, 6) = $sn
$Sheet.Cells.Item($intRow, 7) = $disks

$intRow++
}

$WorkBook.EntireColumn.AutoFit()

sleep 5

#Disconnect-VIServer
#end of script