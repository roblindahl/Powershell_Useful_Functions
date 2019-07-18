FUNCTION GETVERSIZE {
    [cmdletbinding()]
    PARAM(
          [string]$connection = "localhost"
         )
## Connect and get the edition of the local server
Add-Type -AssemblyName 'Microsoft.SqlServer.Smo, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91'

    $server = New-Object Microsoft.SqlServer.Management.Smo.Server -ArgumentList $connection
    
    Write-Output ("`n`nServer: {0}`nEdition: {1}`nBuild: {2}`n`n" -f $server.Name, $server.Edition, $server.Version)
    foreach ($db in $server.Databases){
        Write-Output ("DatabaseName: {0}   Size (MB): {1} " -f 
        $db.Name, $db.Size)
    }

}##END FUNCTION GETVERSIZE
