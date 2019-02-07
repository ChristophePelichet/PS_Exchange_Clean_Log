
#   ██████╗██╗  ██╗██████╗ ██╗███████╗████████╗ ██████╗ ██████╗ ██╗  ██╗███████╗    ██████╗ ███████╗██╗     ██╗ ██████╗██╗  ██╗███████╗████████╗
#  ██╔════╝██║  ██║██╔══██╗██║██╔════╝╚══██╔══╝██╔═══██╗██╔══██╗██║  ██║██╔════╝    ██╔══██╗██╔════╝██║     ██║██╔════╝██║  ██║██╔════╝╚══██╔══╝
#  ██║     ███████║██████╔╝██║███████╗   ██║   ██║   ██║██████╔╝███████║█████╗      ██████╔╝█████╗  ██║     ██║██║     ███████║█████╗     ██║   
#  ██║     ██╔══██║██╔══██╗██║╚════██║   ██║   ██║   ██║██╔═══╝ ██╔══██║██╔══╝      ██╔═══╝ ██╔══╝  ██║     ██║██║     ██╔══██║██╔══╝     ██║   
#  ╚██████╗██║  ██║██║  ██║██║███████║   ██║   ╚██████╔╝██║     ██║  ██║███████╗    ██║     ███████╗███████╗██║╚██████╗██║  ██║███████╗   ██║   
#   ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝  ╚═╝╚══════╝    ╚═╝     ╚══════╝╚══════╝╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝   ╚═╝   
#   ██████╗ ███████╗████████╗        ██╗      ██████╗  █████╗ ██████╗          ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗                    
#  ██╔════╝ ██╔════╝╚══██╔══╝        ██║     ██╔═══██╗██╔══██╗██╔══██╗        ██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝                    
#  ██║  ███╗█████╗     ██║           ██║     ██║   ██║███████║██║  ██║        ██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗                   
#  ██║   ██║██╔══╝     ██║           ██║     ██║   ██║██╔══██║██║  ██║        ██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║                   
#  ╚██████╔╝███████╗   ██║   ███████╗███████╗╚██████╔╝██║  ██║██████╔╝███████╗╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝                   
#   ╚═════╝ ╚══════╝   ╚═╝   ╚══════╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝                    
#                                                                                                                                               

Function Get_LoadConfig () 
{

Param 
	(
		[Parameter(Mandatory=$true)][string]$Path
	)

<#

.SYNOPSIS 
	Fonction pour charger un fichier de configuration au format .xml
	Function to load a configuration file in .xml format
	
.DESCRIPTION
	Fonction pour charger un fichier de configuration au format .xml
	Function to load a configuration file in .xml format
	
.EXAMPLE
	Get_LoadConfig -path <config_xml_path>

.LINK
	

.NOTES

Written by : Christophe Pelichet
Version:     1.0

Find me on : 

	* LinkedIn:	www.linkedin.com/in/christophe-pelichet-868bb644
	* Github:	https://github.com/christophepelichet

#>


	


	$global:appSettings = @{}
	$config = [xml](get-content $path)

		foreach ($addNode in $config.configuration.appsettings.add) {
			if ($addNode.Value.Contains(‘,’)) 
			{
			# Array case
				$value = $addNode.Value.Split(‘,’)
				for ($i = 0; $i -lt $value.length; $i++) 
				{ 
				$value[$i] = $value[$i].Trim() 
				}
			}
			else 
			{
			# Scalar case
				$value = $addNode.Value
			}
				$global:appSettings[$addNode.Key] = $value
		}
}