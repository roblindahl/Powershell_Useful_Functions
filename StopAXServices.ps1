FUNCTION StopAXServices {
#This function will either start (with the -start flag) or stop services (default behavior) for AX downtimes.
#Considerable Configuration required to fit your environment. If there is a better way I'd love to know it.
#Written May 10 of 2019 by Rob Lindahl    
#Parameters
    [CmdletBinding(DefaultParameterSetname='NonProd')]
    Param(
    #Main integration node is what should be entered for this parameter.
    [Parameter (Mandatory=$true,ParameterSetName='Prod')]
    [Parameter (Mandatory=$false,ParameterSetName='NonProd')]
    [ValidateNotNullOrEmpty()]
    [String]$IntSvcHost1,
    
    #In for Future Use
    [Parameter (Mandatory=$false,ParameterSetName='Prod')]
    [ValidateNotNullOrEmpty()]
    [String]$IntSvcHost2,
    
    #Main AX AOS 
    [Parameter (Mandatory,ParameterSetName='Prod')]
    [Parameter (Mandatory,ParameterSetName='NonProd')]
    [ValidateNotNullOrEmpty()]
    [String]$AXServer1,

    #Secondary AX AOS
    [Parameter (Mandatory,ParameterSetName='Prod')]
    #[ValidateNotNullOrEmpty()]
    [ValidateSet("<YourSecondaryNode>")] #You may use this or you may comment it out
    [String]$AXServer2,
    
    #Tertiary AX AOS
    [Parameter (Mandatory,ParameterSetName='Prod')]
    #[ValidateNotNullOrEmpty()]
    [ValidateSet("<YourTertiaryNode>")] #You may use this or you may comment it out
    [String]$AXServer3,

    [Parameter ()]
    [Switch]$Start

    )


#Declare Variables
If($AXServer1){$Service1 = Get-Service -ComputerName $AXServer1 -Name 'AOS60$01'}

If($AXServer2){$Service2 = Get-Service -ComputerName $AXServer2 -Name 'AOS60$01'}

IF($AXServer3){$Service3 = Get-Service -ComputerName $AXServer3 -Name 'AOS60$01'}

filter timestamp {"$(Get-Date -Format o): $_"}


# Stop or Start Services


    If ($Start){
        Timestamp
            #Yes a switch statement would be cleaner but it is a equality only comparison. No BOOL/conditional allowed. No comp operators. For most of this I need to use BOOL. 
        #Change Out the Environment Designations As Needed as well as any services
        If ($AXServer1 -like "DEV*"){
                IF ($IntSvcHost1){ Set-Service -ComputerName $IntSvcHost1 -Name <IntegrationServiceName> -StartupType Automatic -Status Running } #-Confirm 
                $Service1 | Set-Service -StartupType Automatic -Status Running #-Confirm
        }
        Elseif ($AXServer1 -like "BLD*"){
                IF ($IntSvcHost1){ Set-Service -ComputerName $IntSvcHost1 -Name <IntegrationServiceName> -StartupType Automatic -Status Running } #-Confirm 
                $Service1 | Set-Service -StartupType Automatic -Status Running #-Confirm
        }
        Elseif ($AXServer1 -like "TEST*"){
                IF ($IntSvcHost1){ Set-Service -ComputerName $IntSvcHost1 -Name <IntegrationServiceName> -StartupType Automatic -Status Running } #-Confirm 
                $Service1 | Set-Service -StartupType Automatic -Status Running #-Confirm
        }
        Elseif ($AXServer1 -like "STG*"){
                IF ($IntSvcHost1){ Set-Service -ComputerName $IntSvcHost1 -Name <IntegrationServiceName> -StartupType Automatic -Status Running } #-Confirm 
                $Service1 | Set-Service -StartupType Automatic -Status Running #-Confirm
        }
        Elseif ($AXServer1 -like "PROD*"){
                Set-Service -ComputerName $IntSvcHost1 -Name <IntegrationConsumerServiceName> -StartupType Automatic -Status Running
                Set-Service -ComputerName $IntSvcHost1 -Name <IntegrationPublisherServiceName> -StartupType Automatic -Status Running
                Set-Service -ComputerName $IntSvcHost1 -Name <IntegrationConsumerServiceName> -StartupType Automatic -Status Running
                Set-Service -ComputerName $IntSvcHost1 -Name <IntegrationPublisherServiceName> -StartupType Automatic -Status Running
                Set-Service -ComputerName $IntSvcHost1 -Name <IntegrationConsumerServiceName> -StartupType Automatic -Status Running
                Set-Service -ComputerName $IntSvcHost1 -Name <IntegrationPublisherServiceName> -StartupType Automatic -Status Running
                Set-Service -ComputerName $IntSvcHost1 -Name <IntegrationConsumerServiceName>-StartupType Automatic -Status Running
                Set-Service -ComputerName $IntSvcHost1 -Name <IntegrationPublisherServiceName> -StartupType Automatic -Status Running
                
                #In for future use.
                IF ($IntSvcHost2){
                Set-Service -ComputerName $IntSvcHost2 -Name ???? -StartupType Automatic -Status Running
                Set-Service -ComputerName $IntSvcHost2 -Name ???? -StartupType Automatic -Status Running
                Set-Service -ComputerName $IntSvcHost2 -Name ???? -StartupType Automatic -Status Running
               
                }
                $Service3 | Set-Service -StartupType Automatic -Status Running #-Confirm
                $Service2 | Set-Service -StartupType Automatic -Status Running #-Confirm
                $Service1 | Set-Service -StartupType Automatic -Status Running #-Confirm
                
                
        }
        Else {
            Write-Host "You have entered an unknown system name or perhaps misspelled it."
            BREAK
        }

        If ($AxServer1){$Service1}
        If ($AxServer2){$Service2}
        If ($AxServer3){$Service3}
        If ($IntSvcHost1){Get-Service -ComputerName $IntSvcHost1 | where Name -like 'Wachter*' }
        If ($IntSvcHost2){Get-Service -ComputerName $IntSvcHost2 | where Name -like '???*' }
        Timestamp
    }

    ELSE{


        #Remove Users from AX (Online Sessions) Placeholder for future possibility. I've not had much luck with the Business Connector for AX
        #For Now do this manually.


        #Stop Services on the Nodes
        
            #For Testing:
            #Write-Host "The AX Server(s):" $AXServer1"," $AXServer2"," $AXServer3
            #Write-Host "The Integration Service Hosts:" $IntSvcHost1"," $IntSvcHost2 
            #Get-Service -ComputerName <ServerName> | where {$_.name -like '<identifiesService>*'}
            #Get-Service -ComputerName <ServerName> | where {$_.name -like '*AOS*'}

        If ($AXServer1){
            Timestamp
            If ($AXServer1 -like "DEV*"){
                IF ($IntSvcHost1){ 
                    Set-Service -ComputerName $IntSvcHost1 -Name <IntegrationServiceName> -StartupType Manual -Status Stopped
                    #Get-Service -ComputerName $IntSvcHost1 -Name <IntegrationServiceName> | Stop-Service -Force
                 } 
                    $Service1 | Set-Service -StartupType Manual
                    $Service1 | Stop-Service -Force #had to do this way because Set-Service doesn't work with dependancies
            }
            Elseif ($AXServer1 -like "BLD*"){
                    IF ($IntSvcHost1){ Set-Service -ComputerName $IntSvcHost1 -Name <IntegrationServiceName> -StartupType Manual -Status Stopped } #-Confirm 
                    $Service1 | Set-Service -StartupType Manual
                    $Service1 | Stop-Service -Force #had to do this way because Set-Service doesn't work with dependancies
            }
            Elseif ($AXServer1 -like "TEST*"){
                    IF ($IntSvcHost1){ Set-Service -ComputerName $IntSvcHost1 -Name <IntegrationServiceName> -StartupType Manual -Status Stopped } #-Confirm 
                    $Service1 | Set-Service -StartupType Manual
                    $Service1 | Stop-Service -Force #had to do this way because Set-Service doesn't work with dependancies
            }
            Elseif ($AXServer1 -like "STG*"){
                    IF ($IntSvcHost1){ Set-Service -ComputerName $IntSvcHost1 -Name <IntegrationServiceName> -StartupType Manual -Status Stopped } #-Confirm 
                    $Service1 | Set-Service -StartupType Manual
                    $Service1 | Stop-Service -Force #had to do this way because Set-Service doesn't work with dependancies
            }
            Elseif ($AXServer1 -like "PROD*"){
                    Set-Service -ComputerName $IntSvcHost1 -Name <IntegrationServiceName> -StartupType Manual -Status Stopped  
                    Set-Service -ComputerName $IntSvcHost1 -Name <IntegrationServiceName>-StartupType Manual -Status Stopped  
                    Set-Service -ComputerName $IntSvcHost1 -Name <IntegrationServiceName> -StartupType Manual -Status Stopped 
                    Set-Service -ComputerName $IntSvcHost1 -Name <IntegrationServiceName> -StartupType Manual -Status Stopped 
                    Set-Service -ComputerName $IntSvcHost1 -Name <IntegrationServiceName> -StartupType Manual -Status Stopped 
                    Set-Service -ComputerName $IntSvcHost1 -Name <IntegrationServiceName> -StartupType Manual -Status Stopped 
                    Set-Service -ComputerName $IntSvcHost1 -Name <IntegrationServiceName> -StartupType Manual -Status Stopped 
                    Set-Service -ComputerName $IntSvcHost1 -Name <IntegrationServiceName> -StartupType Manual -Status Stopped 
                   
                   #This is in here for future use case. As of the creation there is no second interface node required.
                   IF ($IntSvcHost2){
                    Set-Service -ComputerName $IntSvcHost2 -Name ???? -StartupType Manual -Status Stopped
                    Set-Service -ComputerName $IntSvcHost2 -Name ???? -StartupType Manual -Status Stopped
                    Set-Service -ComputerName $IntSvcHost2 -Name ???? -StartupType Manual -Status Stopped
                    Set-Service -ComputerName $IntSvcHost2 -Name ???? -StartupType Manual -Status Stopped
                    Set-Service -ComputerName $IntSvcHost2 -Name ???? -StartupType Manual -Status Stopped
                    Set-Service -ComputerName $IntSvcHost2 -Name ???? -StartupType Manual -Status Stopped
                    Set-Service -ComputerName $IntSvcHost2 -Name ???? -StartupType Manual -Status Stopped
                    Set-Service -ComputerName $IntSvcHost2 -Name ???? -StartupType Manual -Status Stopped
                    }
                    
                    $Service3 | Set-Service -StartupType Manual
                    $Service3 | Stop-Service -Force #had to do this way because Set-Service doesn't work with dependancies                    
                    $Service2 | Set-Service -StartupType Manual
                    $Service2 | Stop-Service -Force #had to do this way because Set-Service doesn't work with dependancies                    
                    $Service1 | Set-Service -StartupType Manual
                    $Service1 | Stop-Service -Force #had to do this way because Set-Service doesn't work with dependancies
                    
                    
            }
            Else {
                Write-Host "You have entered an unknown system name or perhaps misspelled it."
                BREAK
            }

            If ($AxServer1){$Service1}
            If ($AxServer2){$Service2}
            If ($AxServer3){$Service3}
            If ($IntSvcHost1){Get-Service -ComputerName $IntSvcHost1 | where Name -like '<identifiesService>*'}
            If ($IntSvcHost2){Get-Service -ComputerName $IntSvcHost2 | where Name -like '???*' }
            Timestamp
        }
    }   
}## END FUNCTION StopAXServices
