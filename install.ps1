# Description: Boxstarter Script
# Author: Microsoft
# Common settings for web development with NodeJS

Disable-UAC
Set-ExecutionPolicy Bypass
Disable-MicrosoftUpdate

# Get the base URI path from the ScriptToCall value
$helperUri =  ".\scripts"
write-host "helper script base URI is $helperUri"

function executeScript {
    Param ([string]$script)
    $scr = "$helperUri\$script"
    write-host "executing $scr ..."
	Invoke-Expression $scr
}

#--- Setting up Windows ---
executeScript "SystemConfiguration.ps1";
executeScript "FileExplorerSettings.ps1";
executeScript "RemoveDefaultApps.ps1";
executeScript "HyperV.ps1";
executeScript "Docker.ps1";
executeScript "WSL.ps1";
executeScript "DevTools.ps1";
executeScript "Browsers.ps1";
executeScript "Others.ps1";

Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
