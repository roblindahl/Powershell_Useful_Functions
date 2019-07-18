FUNCTION Get-FailoverList {
    [cmdletbinding()]
    PARAM(
        [parameter(Mandatory=$true,
        HelpMessage="Enter the name of the Listener (for AOAG), VIP(For FCI).")]
        [string]
        $ComputerName   
    )
    #Pull the related events to fail-over. Helps keep tabs or give a quick check in case someone is asking when it last happened.
    Get-winEvent -ComputerName $ComputerName -filterHashTable @{logname ='Microsoft-Windows-FailoverClustering/Operational'; id=1641}| ft -AutoSize -Wrap
    
}#END Get-FailoverList FUNCTION
