#===============================================================================
# This script will help with the quick setup and installation of 
# tools and applications for new Continis.
#===============================================================================
# tech-support slack channel
$slack="https://contino.slack.com/archives/C1TER2RQQ"

#===============================================================================
# Optional Tools/Apps to be installed for Windows OS
#===============================================================================
$Windowsoptions = @(
    "Tabby Terminal",
    "Packer",
    "Consul",
    "Vault",
    "IntelliJ",
    "Golang",
    "Pre-Commit Hooks")

# Check if host is console
if ($host.Name -ne 'ConsoleHost') {
    Write-Error "[$($host.Name)] Cannot run inside current host, please use a console window instead!"
    return
}

#===============================================================================
#  Functions
#===============================================================================

function Check-Administrator  
{  
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Check-Command($cmdname) {
    return [bool](Get-Command -Name $cmdname -ErrorAction SilentlyContinue)
}

function Update-Environment-Path {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}

function Push-User-Path($userPath) {
    $path = [Environment]::GetEnvironmentVariable('Path', 'User')
    $newpath = "$userPath;$path"
    [Environment]::SetEnvironmentVariable("Path", $newpath, 'User')
    Update-Environment-Path
}

function msgHeading($str) {
    Write-Host ""
    Write-Host "$str" -ForegroundColor Green 
}

function msgDivider() {
    "-"*80 | Write-Host -ForegroundColor Green 
}

# Installation notification message Windows
function msgInstallStepWindows($str) {
    msgDivider
    Write-Host ""
    Write-Host "Installing $str...." -ForegroundColor Green 
    Write-Host ""
}

# Logo with Welcome message
function logoPrint {
    echo @'
         _____            _   _             
        / ____|          | | (_)            
       | |     ___  _ __ | |_ _ _ __   ___  
       | |    / _ \| '_ \| __| | '_ \ / _ \ 
       | |___| (_) | | | | |_| | | | | (_) |
        \_____\___/|_| |_|\__|_|_| |_|\___/   
     -----------------------------------------------------------------------------
        D E V O P S   T O O L S/A P P S   S E T U P   S C R I P T
    
        NOTE: You can exit the script at any time by pressing CONTROL+C a bunch.
     -----------------------------------------------------------------------------
'@
}

# Default tools to be insatlled
function windowsToolsApps {
    Write-Host "Git      wget     Google Chrome     Terraform `n
Slack    Zoom    Visual-Studio-Code      Python`n
Docker   WS-CLI   Kubectl      Node      Azure CLI"
}

# Display Menu
function windowsMenuLoop() {
    msgHeading "By default, the following tools and Apps will be installed"
    msgDivider
    windowsToolsApps
    msgHeading "Select Optional Additional Tools/Apps"
    msgDivider
    Write-Host ""
    for ($i=1; $i -le $Windowsoptions.count; $i++) { 
        Write-Host "$i - $($Windowsoptions[$i-1])"
    }
}

# Success message after installation
function successMsg() {
    msgHeading "Installation Completed...Restart your computer to ensure all updates take effect."
    msgDivider
    Write-Host ""
    Write-Host @'
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        |||||||||||||||||||||||||||| Next Steps ||||||||||||||||||||||||||||
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        +                                                                  +
        +    You might need some licnese to use the premium/enterprise     +
        +                 features of some of these tools/Apps.            +
        +                                                                  +
        +    The link below will connect you to the tech-support team.     +
        +                                                                  +
        +                                                                  +
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'@ -ForegroundColor Green
    Write-Host ""
    Write-Host "Link: $slack" -ForegroundColor Green
    Write-Host ""
    Write-Host ""
    Write-Host -NoNewLine 'Press any key to go to the tech-support channel...' -ForegroundColor Green
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown') 
    start $slack

    exit
}

# failed message if installation was unable to complete
function failedMsg() {
    Write-Host "Script Failed" -ForegroundColor Red
    "-"*80 | Write-Host -ForegroundColor Red

    Write-Host ""
    Write-Host @'
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        |||||||||||||||||||||||||||| Next Steps ||||||||||||||||||||||||||||
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        +                                                                  +
        +           Contact tech-support team to finish setup.             +
        +                                                                  +
        +    The link below will connect you to the tech-support team.     +
        +                                                                  +
        +                                                                  +
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'@ -ForegroundColor Red
    Write-Host ""
    Write-Host "Link: $slack" -ForegroundColor Red
    Write-Host ""
    Write-Host ""
    Write-Host -NoNewLine 'Press any key to go to the tech-support channel...' -ForegroundColor Red
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown') 
    start $slack

    exit
}

#===============================================================================
# Windows setup function
#===============================================================================
function windowsOS() {
    windowsMenuLoop
    Write-Host ""
    $choice = Read-Host "Select addtional tools by pressing number (1 - 7).`nPress ENTER to continue when done with the selection"
    $ok = $choice -match '[1234567]+$'
    if ( -not $ok) {
        Write-Host "Invalid selection" -ForegroundColor Red
        sleep 2
        Write-Host ""
    }

    msgHeading "Installing general utilities..."
    if (Check-Command -cmdname 'choco') {
        Write-Host "Choco is already installed, skip installation."
    }
    else {
        Write-Host ""
        msgInstallStepWindows "Chocolatey"
        Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
        Update-Environment-Path
    }

    RefreshEnv.cmd

    # Install the default tools/Apps
    msgHeading "Installing the must-have Packages"
    # Install Git
    msgInstallStepWindows "Git"                         
    choco install -y git
    Update-Environment-Path

    # Install wget
    msgInstallStepWindows "wget"                         
    choco install -y wget
    Update-Environment-Path

    # Install Terraform
    msgInstallStepWindows "Terraform"
    choco install -y terraform
    Update-Environment-Path

    # Install Chrome
    msgInstallStepWindows "Google Chrome"  
    choco install -y googlechrome
    Update-Environment-Path

    # Install Slack
    msgInstallStepWindows "Slack"
    choco install -y slack
    Update-Environment-Path

    # Install Zoom
    msgInstallStepWindows "Zoom"
    choco install -y zoom
    Update-Environment-Path

    # Install Visual Studio Code
    msgInstallStepWindows "Visual Studio Code"     
    choco install -y vscode
    Update-Environment-Path

    # Install Python
    msgInstallStepWindows "Python"                    
    choco install -y python
    Update-Environment-Path

    # Install Docker
    msgInstallStepWindows "Docker"
    choco install -y docker-desktop
    Update-Environment-Path

    # Install AWS CLI
    msgInstallStepWindows "AWS CLI"                     
    choco install -y awscli
    Update-Environment-Path

    # Install Kubectl
    msgInstallStepWindows "Kubectl"                     
    choco install -y kubernetes-cli
    Update-Environment-Path

    # Install Node
    msgInstallStepWindows "Node"                        
    choco install -y nodejs-lts
    Update-Environment-Path

    # Install Node
    msgInstallStepWindows "Azure CLI"                        
    choco install -y azure-cli
    Update-Environment-Path

    # Install  Optional Apps
    msgHeading "Installing additional Tools and Applications"

    switch -Regex ( $choice ) {
        "1" {
            msgInstallStepWindows "Tabby Terminal"
            choco install tabby -y
            Update-Environment-Path
        }
        "2" {
            msgInstallStepWindows "Packer"
            choco install packer -y
            Update-Environment-Path
        }
        "3" {
            msgInstallStepWindows "Consul"
            choco install consul -y
            Update-Environment-Path
        }
        "4" {
            msgInstallStepWindows "Vault"
            choco install vault -y
            Update-Environment-Path
        }
        "5" {
            msgInstallStepWindows "IntelliJ" 
            choco install intellijidea-community
            Update-Environment-Path
        }
        "6" {
            msgInstallStepWindows "Golang" 
            choco install golang
            Update-Environment-Path
        }
        "7" {
            msgInstallStepWindows "Pre-Commit" 
            pip install pre-commit
            msgInstallStepWindows "TFLint" 
            choco install tflint
            msgInstallStepWindows "TFSec" 
            choco install tfsec
            msgInstallStepWindows "Checkov" 
            pip install checkov
            msgInstallStepWindows "Terraform Docs" 
            choco install terraform-docs
            Update-Environment-Path
        }
    }

    msgDivider
}

if(-not (Check-Administrator)) {
    Write-Warning "You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator!"
    Write-Host ""
    failedMsg
} else {
    # Print logo
    logoPrint

    $loggedInUser = whoami
    msgHeading "Hi $loggedInUser,"
    windowsOS
    successMsg
}
