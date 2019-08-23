FUNCTION CopyModelLocal{

#Remove drive map if it exists so we have a clean start
if (Get-PSDrive W -ErrorAction SilentlyContinue) {
    Remove-PSDrive -Name "W"
} 
else {
    #Setup the drive map
    New-PSDrive -Persist -Scope "Global" -Name "W" -Root "<YourRoot to your TFS Build repository>" -PSProvider FileSystem #|Out-Null
}

$root = "W:\*"
$folder = Get-Item -Path $root | Where-Object { $_.CreationTime -ge (Get-Date).AddHours(-22)}
$file = "C:\users\$Env:UserName\Desktop\RC$(Get-Date -Format MMddyyyy).axmodel"  #Change to suit your own standards for file name convention
#$file
If($folder){
 #$folder
    Try {
        Copy-Item -Path $folder\*.axmodel -Destination $file -Recurse
        "$file successfully copied."
    }
    Catch {
        Pause -message "Something went wrong with the copy. Please report this andmove the model file manually.Once you have done so you should be able to continue (press any key to do so)."
    
    }
}
    ELSE{ "An unknown error has prevented the operation. Please report this to the script owner. Once this is fixed, please rerun the script. The Script will now exit."
        Dip #can be removed if you don't want the script to exit. Also requires Dip Function from this GIT Repository:https://github.com/RyderOfTheVeil/Powershell_UsefulFunctions
        
    }
Remove-PSDrive -Name "W"
}##END FUNCTION CopyModelLocal
