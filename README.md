# Windows 10 Web Development Environment using Chocolatey

Run PowerShell as Administrator, then:

```sh
Set-ExecutionPolicy Unrestricted --Force
```

Now, click on the following link using Microsoft Edge:

[INSTALL WINDOWS DEV ENVIRONMENT](http://boxstarter.org/package/nr/url?https://github.com/harrysbaraini/windows-dev-env/raw/master/install.ps1)

Or, run the following command on PowerShell as Administrator:

```sh
START http://boxstarter.org/package/nr/url?https://github.com/harrysbaraini/windows-dev-env/raw/master/install.ps1
```

## System Configuration

It will set some system configuration and set some ffile expoorer settings, then it will
remove some default Windows apps. After that, it will install Hyper-V, WSL Docker and Lando.

### Installing Lando

When Lando installer launches, please uncheck _Git For Windows_ and _Docker_, because this script
installs Git and Docker.

## Browsers

It will install Google Chrome and Firefox.

# Dev Tools

It will install following tools:

- VS Code
- Notepad++
- Git
- Python & Python 2
- 7zip
- SysInternals
- Putty
- Cmder
- Insomnia API Client
- Nodejs LTS
- Yarn
- PHP
- Composer
- PhpStorm
- Datagrip
- MicrosoftWebDriver

# TODO

- Automatically load PHP Storm settings
- Generate SSH
