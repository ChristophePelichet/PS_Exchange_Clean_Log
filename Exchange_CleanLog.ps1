#  ███████╗██╗  ██╗ ██████╗██╗  ██╗ █████╗ ███╗   ██╗ ██████╗ ███████╗         ██████╗██╗     ███████╗ █████╗ ███╗   ██╗        ██╗      ██████╗  ██████╗ 
#  ██╔════╝╚██╗██╔╝██╔════╝██║  ██║██╔══██╗████╗  ██║██╔════╝ ██╔════╝        ██╔════╝██║     ██╔════╝██╔══██╗████╗  ██║        ██║     ██╔═══██╗██╔════╝ 
#  █████╗   ╚███╔╝ ██║     ███████║███████║██╔██╗ ██║██║  ███╗█████╗          ██║     ██║     █████╗  ███████║██╔██╗ ██║        ██║     ██║   ██║██║  ███╗
#  ██╔══╝   ██╔██╗ ██║     ██╔══██║██╔══██║██║╚██╗██║██║   ██║██╔══╝          ██║     ██║     ██╔══╝  ██╔══██║██║╚██╗██║        ██║     ██║   ██║██║   ██║
#  ███████╗██╔╝ ██╗╚██████╗██║  ██║██║  ██║██║ ╚████║╚██████╔╝███████╗███████╗╚██████╗███████╗███████╗██║  ██║██║ ╚████║███████╗███████╗╚██████╔╝╚██████╔╝
#  ╚══════╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝╚══════╝ ╚═════╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝ ╚═════╝  ╚═════╝ 
#                                                                                                                                                         
<#

.SYNOPSIS 

	
.DESCRIPTION

	
.EXAMPLE


.LINK
	

.NOTES

Written by : Christophe Pelichet
Version:     1.0

Find me on : 

	* LinkedIn:	www.linkedin.com/in/christophe-pelichet-868bb644
	* Github:	https://github.com/christophepelichet

#>










##############################################################################################################################################################
################################################################## SCRIPT PATH ###############################################################################
##############################################################################################################################################################

$MyScriptPath 		=  Split-Path $script:MyInvocation.MyCommand.Path								# Path du Script
$MyScriptFunctions	= "$MyScriptPath\Functions"														# Path du répertoire des fonctions
$MyScriptLog		= "$MyScriptPath\Log"															# Path du répertoire de logs
$MyScriptConfdir	= "$MyScriptPath\Conf"															# Path du répertoire de configuration
$MyScriptConfname 	= "config.xml"																	# Nom du fichier de configuration


##############################################################################################################################################################
#################################################################  GET_LOAD_CONFIG  ##########################################################################
##############################################################################################################################################################

### Concatenation du path du fichier de configuration
$MyScriptConfig   = $MyScriptConfdir+"\"+ $MyScriptConfname											

### Chargement de la fonction Get_LoadConfig et du fichier de configuration
$MyLoadConf = $MyScriptFunctions +"\"+ "Get_LoadConfig.ps1"											
	. $MyLoadConf																					
	Get_LoadConfig -path $MyScriptConfig	


##############################################################################################################################################################
################################################################ PATH CONCATENATION ##########################################################################
##############################################################################################################################################################	
	
##############################################################################################################################################################
############################################################# CONFIG FILE TO VARIABLES #######################################################################
##############################################################################################################################################################	

### Retention
$RetentionDay 	 = $appSettings["RetentionDay"]							 						# Envoie du rapport par email :   1 activé / 0 désactivé


	
###############################################################################################################################################################
##################################################### MERCI DE NE RIEN MODIFIER APRES CETTE LIGNE ############################################################# 
###############################################################################################################################################################


# Control que IIS est Installé

if ((Get-WindowsFeature Web-Server).InstallState -eq "Installed") {
	# Clear Variables
	$WWWSite 		= $NULL
	$WWWSiteLogDir	= $NULL
	
	# Get Web Site Log Dir Path
	$WWWSite 		= Get-website -name "Default Web Site" | Select logFile
	$WWWSiteLogDir 	= $WWWSite.LogFile.Directory -Replace '%SystemDrive%', $env:SystemDrive
} 
else 
{
    Write-Host "IIS is not installed on $vm"
}







<# S
$ExchangeLoggingPath="C:\Program Files\Microsoft\Exchange Server\V15\Logging\"

Write-Host "Removing IIS and Exchange logs; keeping last" $days "days"

Function CleanLogfiles($TargetFolder)
{
    if (Test-Path $TargetFolder) {
        $Now = Get-Date
        $LastWrite = $Now.AddDays(-$days)
        $Files = Get-ChildItem $TargetFolder -Include *.log,*.blg -Recurse | Where {$_.LastWriteTime -le "$LastWrite"}
        foreach ($File in $Files)
            {Write-Host "Deleting file $File" -ForegroundColor "Red"; Remove-Item $File -ErrorAction SilentlyContinue | out-null}
       }
Else {
    Write-Host "The folder $TargetFolder doesn't exist! Check the folder path!" -ForegroundColor "red"
    }
}
CleanLogfiles($IISLogPath)
CleanLogfiles($ExchangeLoggingPath) #>
