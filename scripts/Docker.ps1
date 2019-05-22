$location = Get-Location

Enable-WindowsOptionalFeature -Online -FeatureName containers -All
RefreshEnv
choco install -y docker-for-windows
choco install -y vscode-docker

#--- Lando ---
New-Item -ItemType Directory -Force -Path "$location\tools"
$landoFile = "$location\tools\lando.exe"

(New-Object System.Net.WebClient).DownloadFile("https://github.com/lando/lando/releases/download/v3.0.0-rc.16/lando-v3.0.0-rc.16.exe", $landoFile)
&$landoFile