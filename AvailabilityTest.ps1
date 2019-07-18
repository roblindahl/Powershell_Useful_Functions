FUNCTION Ping-Availability {
    [cmdletbinding()]
    PARAM(
        [string]$CompPrefix = "172.16.12.",   #only fill in the first three octets here
        [int]$start = 81,
        [int]$end = 81
    )
    #$start..$end | foreach {Test-Connection "$CompPrefix$_" -count 1 -Quiet }
    Write-Verbose "Pinging $CompPrefix From $start to $end"
    #construct ip address then test availability with ping
    $start..$end | where-object {Test-Connection "$CompPrefix$_" -count 1 -Quiet } |foreach {"$CompPrefix$_" }
}#END Ping-Availability FUNCTION
