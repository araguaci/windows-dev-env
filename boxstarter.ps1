# Description: Boxstarter Script
# Author: Vanderlei Sbaraini Amancio
# Common settings for web development

$location = "C:\windows-dev-env"
$webClient = New-Object System.Net.WebClient
$objShell = New-Object -ComObject Shell.Application

Disable-UAC
Set-ExecutionPolicy Unrestricted -Force
Disable-MicrosoftUpdate

New-Item -ItemType Directory -Force -Path $location

# ---------------------------------------------------
# Set up Windows
# ---------------------------------------------------

Write-Host "Change Windows settings" -ForegroundColor "Yellow"

# Disable game bar tips on what Windows think is a game
Disable-GameBarTips
# Enable developer mode on the system
Set-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\AppModelUnlock -Name AllowDevelopmentWithoutDevLicense -Value 1

# ---------------------------------------------------
# File Explorer Settings
# ---------------------------------------------------

Write-Host "Update some File Explorer settings" -ForegroundColor "Yellow"

# Make Windows Explorer tolerable
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions
# will expand explorer to the actual folder you're in
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneExpandToCurrentFolder -Value 1
#adds things back in your left pane like recycle bin
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneShowAllFolders -Value 1
#opens PC to This PC, not quick access
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Value 1
#taskbar where window is open for multi-monitor
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name MMTaskbarMode -Value 2

# ---------------------------------------------------
# Remove unwanted applications that come with Windows
# out of the box.
#
# Referenced to build script
# https://docs.microsoft.com/en-us/windows/application-management/remove-provisioned-apps-during-update
# https://github.com/jayharris/dotfiles-windows/blob/master/windows.ps1#L157
# https://gist.github.com/jessfraz/7c319b046daa101a4aaef937a20ff41f
# https://gist.github.com/alirobe/7f3b34ad89a159e6daa1
# https://github.com/W4RH4WK/Debloat-Windows-10/blob/master/scripts/remove-default-apps.ps1
# ---------------------------------------------------

Write-Host "Uninstall some applications that come with Windows out of the box" -ForegroundColor "Yellow"

function removeApp {
	Param ([string]$appName)
	Write-Output "Trying to remove $appName"
	Get-AppxPackage $appName -AllUsers | Remove-AppxPackage
	Get-AppXProvisionedPackage -Online | Where DisplayNam -like $appName | Remove-AppxProvisionedPackage -Online
}

$applicationList = @(
	"Microsoft.BingFinance"
	"Microsoft.3DBuilder"
	"Microsoft.BingFinance"
	"Microsoft.BingNews"
	"Microsoft.BingSports"
	"Microsoft.BingWeather"
	"Microsoft.CommsPhone"
	"Microsoft.Getstarted"
	"Microsoft.WindowsMaps"
	"*MarchofEmpires*"
	"Microsoft.GetHelp"
	"Microsoft.Messaging"
	"*Minecraft*"
	"Microsoft.MicrosoftOfficeHub"
	"Microsoft.OneConnect"
	"Microsoft.WindowsPhone"
	"Microsoft.WindowsSoundRecorder"
	"*Solitaire*"
	"Microsoft.MicrosoftStickyNotes"
	"Microsoft.Office.Sway"
	"Microsoft.XboxApp"
	"Microsoft.XboxIdentityProvider"
	"Microsoft.ZuneMusic"
	"Microsoft.ZuneVideo"
	"Microsoft.NetworkSpeedTest"
	"Microsoft.FreshPaint"
	"Microsoft.Print3D"
	"*Autodesk*"
	"*BubbleWitch*"
    "king.com*"
    "G5*"
	"*Dell*"
	"*Facebook*"
	"*Keeper*"
	"*Netflix*"
	"*Twitter*"
	"*Plex*"
	"*.Duolingo-LearnLanguagesforFree"
	"*.EclipseManager"
	"ActiproSoftwareLLC.562882FEEB491" # Code Writer
	"*.AdobePhotoshopExpress"
);

foreach ($app in $applicationList) {
    removeApp $app
}

# ---------------------------------------------------
# Install Development Tools
# ---------------------------------------------------

# Hyper-V
cinst -y Microsoft-Hyper-V-All -source windowsFeatures

# Docker
Enable-WindowsOptionalFeature -Online -FeatureName containers -All
RefreshEnv
cinst -y docker-for-windows

# Lando
New-Item -ItemType Directory -Force -Path "$location\tools"
$landoFile = "$location\tools\lando.exe"

(New-Object System.Net.WebClient).DownloadFile("https://github.com/lando/lando/releases/download/v3.0.0-rc.16/lando-v3.0.0-rc.16.exe", $landoFile)
&$landoFile

# Essential
cinst -y git --package-parameters="'/GitAndUnixToolsOnPath /WindowsTerminal'"
cinst -y cmder
cinst -y putty
cinst -y googlechrome
cinst -y firefox

# Languages
# cinst -y visualstudio2017buildtools
# cinst -y visualstudio2017-workload-vctools
cinst -y python
cinst -y python2 # Node.js requires Python 2 to build native modules
cinst -y nodejs-lts
cinst -y yarn
cinst -y php
cinst -y composer

# Editors
cinst -y vscode
cinst -y notepadplusplus
cinst -y insomnia-rest-api-client
cinst -y phpstorm
cinst -y datagrip

# VSCode Extensions 
cinst -y vscode-docker
code --install-extension msjsdiag.debugger-for-chrome
code --install-extension msjsdiag.debugger-for-edge
code --install-extension bmewburn.vscode-intelephense-client
code --install-extension felixfbecker.php-debug
code --install-extension neilbrayfield.php-docblocker
code --install-extension kokororin.vscode-phpfmt
code --install-extension Yish.php-snippets-for-vscode
code --install-extension marabesi.php-import-checker
code --install-extension sevavietl.php-files
code --install-extension octref.vetur
code --install-extension isudox.vscode-jetbrains-keybindings
code --install-extension SolarLiner.linux-themes
code --install-extension cjhowe7.laravel-blade
code --install-extension amiralizadeh9480.laravel-extra-intellisense

# Others
cinst -y microsoftwebdriver

# Update settings for CMDER
$webClient.DownloadFile("https://github.com/harrysbaraini/windows-dev-env/raw/master/cmder/settings.xml", "$location\cmder\settings.xml");

Move-Item -Path "C:\tools\Cmder\vendor\conemu-maximus5\ConEmu.xml" -Destination "C:\tools\Cmder\vendor\conemu-maximus5\ConEmu.xml.bkp"
Copy-Item -Path "$location\cmder\settings.xml" -Destination "C:\tools\Cmder\vendor\conemu-maximus5\"

If ($Env:Path -match [Regex]::Escape("C:\tools\Cmder\bin")) {
    [System.Environment]::SetEnvironmentVariable("PATH", $Env:Path + ";C:\tools\Cmder\bin", "User")
}

# ---------------------------------------------------
# Tools not related to development.
# ---------------------------------------------------

cinst -y 7zip.install
cinst -y vlc
cinst -y adobereader
cinst -y spotify
cinst -y slack
cinst -y sysinternals

# Fonts
$fontsFolder = $objShell.Namespace(0x14)

New-Item -ItemType Directory -Force -Path  "$location\fonts"

$webClient.DownloadFile("https://github.com/kencrocken/FiraCodeiScript/raw/master/FiraCodeiScript-Bold.ttf", "$location\fonts\FiraCodeiScript-Bold.ttf")
$webClient.DownloadFile("https://github.com/kencrocken/FiraCodeiScript/raw/master/FiraCodeiScript-Regular.ttf", "$location\fonts\FiraCodeiScript-Regular.ttf")
$webClient.DownloadFile("https://github.com/kencrocken/FiraCodeiScript/raw/master/FiraCodeiScript-Italic.ttf", "$location\fonts\FiraCodeiScript-Italic.ttf")

foreach($File in $(Get-ChildItem ".\fonts")) {
    $fontsFolder.CopyHere($File.fullname)
}

cinst -y firacode
cinst -y hackfont

# ---------------------------------------------------
# Reactivate User Acess Control and Microsoft Update
# ---------------------------------------------------

Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula