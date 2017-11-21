# start of function
function vToolVerCheck {
<#
.SYNOPSIS
    check vtool version
.DESCRIPTION
    goes to the project page of vtool, checks the last updated date.
    Based on the date it lets us know whether the vTool is outdated or
    updated.
.NOTES
    File Name      : vToolVerCheck.ps1
    Author         : gajendra d ambi
    updated        : 2017Nov21
    Prerequisite   : PowerShell v4+ win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/MrAmbig/vmware/vtool
#>
    $url = 'https://github.com/MrAmbiG/vmware/tree/master/vTool'
    $respo = Invoke-WebRequest $url
    if ($respo.StatusCode -eq 200) {
        $vers = $respo.Headers.Date.split(' ')
        $vers = 'vTool_'+$vers[3]+$vers[2]+$vers[1] 
    if ($vers -ne $version) {
        Write-Host "your version of vTool : $version
        Latest version of vTool : $vers
        Consider updating it for best functionality
        "
        $choice = Read-Host "choose one of the below
        1. Update vTool
        0. May be later
        "
        if ($choice -eq 1) { Start-Process $url } else { write ':(' }
        } else
        {Write-Host 'your vTool seems to be up to date' }
    }
}
# end of function
