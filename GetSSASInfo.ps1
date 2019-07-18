FUNCTION GETSSASINFO{
    [cmdletbinding()]
    PARAM(
          [string]$connection = "localhost"
         )
## Connect and get the edition of the local server
Add-Type -AssemblyName 'Microsoft.AnalysisServices, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91'

    $server = New-Object Microsoft.AnalysisServices.Server
    $server.connect($connection)
        Write-Output ("`n`nServer: {0}`nEdition: {1}`nBuild: {2}`n`n" -f 
        $server.Name, $server.Edition, $server.Version)
    foreach ($db in $server.Databases){
        Write-Output ("DatabaseName: {0} Size: {1} Version: {2}" -f 
        $db.Name, $db.EstimatedSize, $db.Version)
    }
}#END FUNCTION GETSSASINFO 
