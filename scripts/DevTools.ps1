choco install -y vscode
choco install -y notepadplusplus
choco install -y git --package-parameters="'/GitAndUnixToolsOnPath /WindowsTerminal'"
choco install -y python
choco install -y putty
choco install -y cmder
choco install -y insomnia-rest-api-client

choco install -y nodejs-lts
choco install -y yarn
# choco install -y visualstudio2017buildtools
# choco install -y visualstudio2017-workload-vctools
choco install -y python2 # Node.js requires Python 2 to build native modules

#--- VSCode Extensions ---
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

#--- PHP ---
choco install -y php
choco install -y composer
choco install -y phpstorm
choco install -y datagrip

#--- Microsoft WebDriver ---
choco install -y microsoftwebdriver

#--- Update Env vars ---
If ($Env:Path -match [Regex]::Escape("C:\tools\Cmder\bin")) {
    [System.Environment]::SetEnvironmentVariable("PATH", $Env:Path + ";C:\tools\Cmder\bin", "User")
}
