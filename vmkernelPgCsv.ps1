#start of function
function vmkernelPgCsv
{
Write-Host "
A CSV file will be opened (open in excel/spreadsheet)
populate the values,
save & close the file,
Hit Enter to proceed
" -ForegroundColor Blue -BackgroundColor White
$csv = "$PSScriptRoot/HostVds.csv"
get-process | Select-Object vmhost,vss,portgroup,vlan,ip,mask,vmk,mtu | Export-Csv -Path $csv -Encoding ASCII -NoTypeInformation
Start-Process $csv
Read-Host "Hit Enter/Return to proceed"

$csv = Import-Csv $csv

  foreach ($line in $csv) 
 {  # importing data from csv and go line by line
    $vmhost = $($line.vmhost)  
    $vss  = $($line.vss)  
    $portgroup  = $($line.portgroup)
    $vlan  = $($line.vlan)    
    $ip  = $($line.ip)
    $mask  = $($line.mask)
    $vmk  = $($line.vmk)    
    $mtu  = $($line.mtu)    
        
    $esxcli = get-vmhost $vmhost | get-esxcli -v2
    (get-vmhost $vmhost).name
    get-vmhost $vmhost | get-virtualswitch -Name $vss | New-VirtualPortGroup -Name $pg -VLanId $vlan -Confirm:$false
    
    # add vmkernel with netstack    
    $esxcliset = $esxcli.network.ip.interface.add 
    $args = $esxcliset.CreateArgs()
    $args.interfacename = "$vmk"
    $args.mtu = "$mtu"    
    $args.portgroupname = "$pg"    
    $esxcliset.Invoke($args)   
     
    # update networking to the vmkernel
    $esxcliset = $esxcli.network.ip.interface.ipv4.set
    $args = $esxcliset.CreateArgs()
    $args.interfacename = "$vmk"
    $args.type = "static"
    $args.ipv4 = "$ip"
    $args.netmask = "$mask"
    $esxcliset.Invoke($args)  
    }
}#End of function

vmkernelPgCsv