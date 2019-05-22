$webClient = New-Object System.Net.WebClient
$objShell = New-Object -ComObject Shell.Application
$objFolder = $objShell.Namespace(0x14)
$location = Get-Location

#--- Fonts ---
New-Item -ItemType Directory -Force -Path  "$location\fonts"

$webClient.DownloadFile("https://github.com/kencrocken/FiraCodeiScript/raw/master/FiraCodeiScript-Bold.ttf", "$location\fonts\FiraCodeiScript-Bold.ttf")
$webClient.DownloadFile("https://github.com/kencrocken/FiraCodeiScript/raw/master/FiraCodeiScript-Regular.ttf", "$location\fonts\FiraCodeiScript-Regular.ttf")
$webClient.DownloadFile("https://github.com/kencrocken/FiraCodeiScript/raw/master/FiraCodeiScript-Italic.ttf", "$location\fonts\FiraCodeiScript-Italic.ttf")

foreach($File in $(Get-ChildItem ".\fonts")) {
    $objFolder.CopyHere($File.fullname)
}

choco install -y firacode
choco install -y hackfont

#--- Not related to development ---
choco install -y vlc
choco install -y FoxitReader
choco install -y spotify
choco install -y slack