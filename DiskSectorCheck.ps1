FUNCTION DiskSector{
    #wrote this because SQL Server doesn't like what is known as Advanced mode for disk sectors (ie 512/4096 vs 512/512 or 4096/4096) 
    #and I needed an easy way to check all disks
    
    $DiskDrives = Get-WmiObject -Class Win32_DiskDrive | Sort-Object -Property Index 
    #$DiskDrives
    If ($DiskDrives) {
                $Object = @()
                foreach ($DiskDrive in $DiskDrives) {
                    $Query = "ASSOCIATORS OF {Win32_DiskDrive.DeviceID='" + $DiskDrive.DeviceID + "'} where AssocClass = Win32_DiskDriveToDiskPartition"
                    $DiskPartitions = Get-WmiObject -Query $Query

                    foreach ($DiskPartition in $DiskPartitions) {
                        $Query2 = "ASSOCIATORS OF {Win32_DiskPartition.DeviceID='" + $DiskPartition.DeviceID + "'} where AssocClass = Win32_LogicalDiskToPartition"
                        $LogicalDisks = Get-WmiObject -Query $Query2

                        foreach ($LogicalDisk in $LogicalDisks) {
                                $LogicalSector = Get-Disk -Number $DiskDrive.Index | SELECT -exp LogicalSectorSize
                                $PhysicalSector = Get-Disk -Number $DiskDrive.Index |SELECT -exp PhysicalSectorSize
                                $nl = [Environment]::NewLine
                                $Object += New-Object PSObject #-Property 
                                    @{DriveLetter = $LogicalDisk.DeviceID } + 
                                    @{LogicalSector = $LogicalSector} + 
                                    @{PhysicalSector = $PhysicalSector} 
                                $Object -join "`r"                                                                            
                        }
                    }
               }
        
    }
    Else{
            "No Disks Found (which is impossible..as there is always an OS Disk) which means there is a problem"
        }
        
} #END FUNCTION DiskSector
