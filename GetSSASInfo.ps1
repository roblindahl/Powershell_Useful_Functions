FUNCTION GETSSASINFO{
    [cmdletbinding()]
    PARAM(
    [string]$connection
    )
## Connect and get the edition of the local server
$connection = "localhost"
$server = New-Object Microsoft.AnalysisServices.Server
$server.connect($connection)
    Write-Output ("`n`nServer: {0}`nEdition: {1}`nBuild: {2}`n`n" -f 
    $server.Name, $server.Edition, $server.Version)
foreach ($db in $server.Databases){
    Write-Output ("DatabaseName: {0} Size: {1} Version: {2}" -f 
    $db.Name, $db.EstimatedSize, $db.Version)
}

}#END FUNCTION GETSSASINFO
