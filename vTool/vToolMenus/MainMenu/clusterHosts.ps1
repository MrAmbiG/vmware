function clusterHosts { # gets a list of hosts from a list of clusters; github.com/MrAmbiG1
$clusters = getClusters
$vmhosts = @()
foreach ($clustername in $clusters) {
$cluster = get-cluster $clustername -ErrorAction SilentlyContinue
if (!$cluster) { write-host no such cluster $clustername } else {
   $vmhosts += $cluster | get-vmhost } }
return $vmhosts}