FUNCTION StorageInfo {
    [cmdletbinding()]
    PARAM(
          [string]$ComputerName = "localhost"
         )
    #Gives basic information on a node's storage
    gwmi -computername $ComputerName win32_volume|where-object {$_.filesystem -match “ntfs”}|ft name,Availability,BlockSize,Compressed,DirtyBitSet,IndexingEnabled,Label,LastErrorCode,PowerManagementCapabilities,Status,@{Name=’CapacityMB’;Expression={$_.Capacity/1MB} },@{Name=’FreeSpaceMB’;Expression={$_.FreeSpace/1MB} }

}#END FUNCTION StorageInfo
