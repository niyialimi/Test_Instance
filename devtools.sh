#!/bin/bash

#===============================================================================
# This script will help with the quick setup and installation of 
# tools and applications for new Continis.
#===============================================================================

# tech-support slack channel
slack="https://contino.slack.com/archives/C1TER2RQQ"

#===============================================================================
# Optional Tools/Apps to be installed for MacOS
#===============================================================================
macoptions[0]="iTerm2";               devtoolchoices[0]="✔"
macoptions[1]="Packer";               devtoolchoices[1]=""
macoptions[2]="Ansible";              devtoolchoices[2]=""
macoptions[3]="Consul";               devtoolchoices[3]=""
macoptions[4]="Vault";                devtoolchoices[4]=""
macoptions[5]="IntelliJ";             devtoolchoices[5]=""
macoptions[6]="Golang";               devtoolchoices[6]=""
macoptions[7]="Pre-Commit Hooks";     devtoolchoices[7]=""
macoptions[8]="Oh-My-Zsh";            devtoolchoices[8]=""

#===============================================================================
# Optional Tools/Apps to be installed for Ubuntu
#===============================================================================
ubuntuoptions[0]="Packer";               devtoolchoices[0]="✔"
ubuntuoptions[1]="Ansible";              devtoolchoices[1]=""
ubuntuoptions[2]="Consul";               devtoolchoices[2]=""
ubuntuoptions[3]="Vault";                devtoolchoices[3]=""
ubuntuoptions[4]="IntelliJ";             devtoolchoices[4]=""
ubuntuoptions[5]="Golang";               devtoolchoices[5]=""
ubuntuoptions[6]="Oh-My-Zsh";            devtoolchoices[6]=""

#===============================================================================
#  Functions
#===============================================================================

msgHeading() {
    printf "\n\n\e[0;36m%s\e[0m \n" "$1"
}

msgDivider() {
    printf %"$COLUMNS"s |tr " " "-"
    printf "\n"
}

# Failed tools/Apps Error Message
errorMsg() {
    printf "\n\e[1;31m"
    printf %"$COLUMNS"s |tr " " "-"
    if [ -z "$1" ]      # Is parameter #1 zero length?
    then
        printf "     There was an error ... somewhere\n"  # no parameter passed.
    else
        printf "\n     Error Installing %s\n" "$1" # parameter passed.
    fi
    printf %"$COLUMNS"s |tr " " "-"
    printf " \e[0m\n"
}

# Installation notification message MacOS
msgInstallStepMac() {
    printf %"$COLUMNS"s |tr " " "-"
    printf "\n\nInstalling %s...\n" "$1";
    $2 || errorMsg "$1"
}

# Installation notification message Linux
msgInstallStepLinux() {
    printf %"$COLUMNS"s |tr " " "-"
    printf "\n\nInstalling %s...\n" "$1";
}

# message for already installed tools/Apps
installMsg() {
    msgDivider
    tput setaf 2 # set text color to green
    printf "✔ %s already installed. Skipping..." "$1"
    tput sgr0 # reset text
}

# Logo with Welcome message
logoPrint() {
cat << "EOT"
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
EOT
}

# Default tools to be insatlled
macToolsApps() {
    tools=("✔Git" "✔Bash" "✔Terraform" "✔Visual-Studio-Code" "✔Slack" \
    "✔Zoom" "✔Docker" "✔Node" "✔Python" "✔Kubectl" "✔AWS-CLI" "✔Chrome")
    # Print Array in Column
    for value in "${tools[@]}"; do 
        printf "%s\n" "${value}"
    done | column
}

linuxToolsApps() {
    tools=("✔Git" "✔Terraform" "✔Visual-Studio-Code" "✔Slack" \
    "✔Zoom" "✔Docker" "✔Node" "✔Python" "✔Kubectl" "✔AWS-CLI" "✔Chrome")
    # Print Array in Column
    for value in "${tools[@]}"; do 
        printf "%s\n" "${value}"
    done | column
}

# Display Menu
macMenuLoop() {
    msgHeading "By default, the following tools and Apps will be installed"
    msgDivider
    macToolsApps
    msgHeading "Select Optional Additional Tools/Apps"
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
        echo ""
        for i in "${!macoptions[@]}"; do
            echo "[""${devtoolchoices[i]:- }""]" $(( i+1 ))") ${macoptions[i]}"
        done
        echo ""
}

linuxMenuLoop() {
    msgHeading "By default, the following tools and Apps will be installed"
    msgDivider
    linuxToolsApps
    msgHeading "Select Optional Additional Tools/Apps"
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
        echo ""
        for i in "${!ubuntuoptions[@]}"; do
            echo "[""${devtoolchoices[i]:- }""]" $(( i+1 ))") ${ubuntuoptions[i]}"
        done
        echo ""
}

macMenuSelect() {
    #===============================================================================
    # Show Tools Selection Menu
    #===============================================================================
    clear
    prompt="Select and Deselect by typing number (1 - 9). Press ENTER/Return to continue when done with the selection"
    while 
        macMenuLoop && \
        read -rp "$prompt" -n1 num && [[ -n "$num" ]];
        
        # echo -n "Select and Deselect by typing number (01 - 20). Hit ENTER to continue when done with the selection: "
        # read -rn 2  num && [[ -n "$num" ]]; \
    do
        clear
        if [[ "$num" == *[[:digit:]]* && $num -ge 1 && $num -le ${#macoptions[@]} ]]; then
            (( num-- ))
            if [[ "${devtoolchoices[num]}" == "✔" ]]; then
                devtoolchoices[num]=""
            else
                devtoolchoices[num]="✔"
            fi
                ERROR="%s" " "
        else
            ERROR="Invalid option: %s" "$num"
        fi
    done
}

linuxMenuSelect() {
    #===============================================================================
    # Show Tools Selection Menu
    #===============================================================================
    clear
    prompt="Select and Deselect by typing number (1 - 7). Press ENTER/Return to continue when done with the selection"
    while 
        linuxMenuLoop && \
        read -rp "$prompt" -n1 num && [[ -n "$num" ]];
        
        # echo -n "Select and Deselect by typing number (01 - 20). Hit ENTER to continue when done with the selection: "
        # read -rn 2  num && [[ -n "$num" ]]; \
    do
        clear
        if [[ "$num" == *[[:digit:]]* && $num -ge 1 && $num -le ${#ubuntuoptions[@]} ]]; then
            (( num-- ))
            if [[ "${devtoolchoices[num]}" == "✔" ]]; then
                devtoolchoices[num]=""
            else
                devtoolchoices[num]="✔"
            fi
                ERROR="%s" " "
        else
            ERROR="Invalid option: %s" "$num"
        fi
    done
}

# Success message after installation
successMsg() {
    msgHeading "Installation Completed...Restart your computer to ensure all updates take effect."
    msgDivider

    tput setaf 2 # set text color to green
    cat << "EOT"
        ╭─────────────────────────────────────────────────────────────────╮
        │░░░░░░░░░░░░░░░░░░░░░░░░░░░ Next Steps ░░░░░░░░░░░░░░░░░░░░░░░░░░│
        ├─────────────────────────────────────────────────────────────────┤
        │                                                                 │
        │   You might need some licnese to use the premium/enterprise     │
        │               features of some of these tools/Apps.             │
        │                                                                 │
        │   The link below will connect you to the tech-support team.     │
        │                                                                 │
        └─────────────────────────────────────────────────────────────────┘
EOT
    tput sgr0 # reset text
    echo "Link: ${slack}"
    echo ""
    echo ""
    tput bold # bold text
    read -n 1 -r -s -p $'             Press any key to go to the tech-support channel...\n\n'
    open ${slack}

    tput sgr0 # reset text

    exit
}

# failed message if installation was unable to complete
failedMsg() {
    tput setaf 1 # set text color to red
    tput bold # bold text
    echo "Script Failed"
    msgDivider

    tput setaf 1 # set text color to red
    cat << "EOT"
        ╭─────────────────────────────────────────────────────────────────╮
        │░░░░░░░░░░░░░░░░░░░░░░░░░░░ Next Steps ░░░░░░░░░░░░░░░░░░░░░░░░░░│
        ├─────────────────────────────────────────────────────────────────┤
        │                                                                 │
        │           Contact tech-support team to finish setup.            │
        │                                                                 │
        │    The link below will connect you to the tech-support team.    │
        │                                                                 │
        └─────────────────────────────────────────────────────────────────┘
EOT
    tput sgr0 # reset text
    echo "Link:${slack}"
    echo ""
    echo ""
    tput bold # bold text
    read -n 1 -r -s -p $'             Press any key to go to the tech-support channel...\n\n'
    open ${slack}

    tput sgr0 # reset text

    exit
}

#===============================================================================
# MacOS setup function
#===============================================================================
macOS() {
    macMenuSelect
    msgHeading "Checking and Installing Brew Packages"

    # Check if xcode is installed
    if type xcode-select >&- && xpath=$( xcode-select -p ) && test -d "${xpath}" && test -x "${xpath}" ; 
    then
        installMsg "Xcode cli tools"
    else
        # Install xcode cli development tools
        msgHeading "Installing xcode cli development tools"
        msgDivider
        xcode-select --install && \
        read -n 1 -r -s -p $'\n\nWhen Xcode cli tools are installed, press ANY KEY to continue...\n\n' || \
        msgDivider
        fi

    # Determine Homebrew prefix
    arch="$(uname -m)"
    if [ "$arch" = "arm64" ]; then
    
        # Apple Silicon M1/M2 Macs
        HOMEBREW_PREFIX="/opt/homebrew"
    else
        # Intel Macs
        HOMEBREW_PREFIX="/usr/local"
    fi

    # Check if Homebrew is not installed
    if ! command -v brew >/dev/null; then
        # Install Brew
        msgHeading "Installing Homebrew"
        msgDivider
        /bin/bash -c  "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
        </dev/null  #Running Homebrew in Non-Interractive mode
        msgDivider
        echo "✔ Setting Path to ${HOMEBREW_PREFIX}/bin:\$PATH"
        export PATH=${HOMEBREW_PREFIX}/bin:$PATH
        msgDivider
    else
        installMsg "Homebrew"

        # Make sure we’re using the latest Homebrew.
        brew update
        msgDivider
    fi

    # Install the default tools/Apps
    msgHeading "Installing the must-have Packages"
    # Install Git
    msgInstallStepMac "Git"                         "brew install git"

    # Install Bash
    msgInstallStepMac "Bash"                        "brew install bash"
    msgInstallStepMac "bash-completion"             "brew install bash-completion"
    msgInstallStepMac "zsh-completions"             "brew install zsh-completions"

    # Install Terraform
    msgInstallStepMac "Terraform"                   "brew install terraform"

    # Install Chrome
    if [[ -d "/Applications/Google Chrome.app" ]]; then
        installMsg "Chrome"
    else
        msgInstallStepMac "Chrome"                  "brew install --cask google-chrome"
    fi

    # Install AWS CLI
    msgInstallStepMac "AWS CLI"                     "brew install awscli"

    # Install Kubectl
    msgInstallStepMac "Kubectl"                     "brew install kubernetes-cli"

    # Install Node
    msgInstallStepMac "Node"                        "brew install node"

    # Install Python
    msgInstallStepMac "Python"                      "brew install python"

    # Install Slack
    if [[ -d "/Applications/Slack.app" ]]; then
        installMsg "Slack"
    else
        msgInstallStepMac "Slack"                   "brew install --cask slack"
    fi

    # Install Zoom
    if [[ -d "/Applications/Zoom.us.app" ]]; then
        installMsg "Zoom"
    else
        msgInstallStepMac "Zoom"                    "brew install --cask zoom"
    fi

    # Install Docker
    if [[ -d "/Applications/Docker.app" ]]; then
        installMsg "Docker"
    else
        msgInstallStepMac "Docker"                  "brew install --cask docker"
    fi

    # Install Visual Studio Code
    if [[ -d "/Applications/Visual Studio Code.app" ]]; then
        installMsg "Visual Studio Code"
    else
        msgInstallStepMac "Visual Studio Code"     "brew install --cask visual-studio-code"
    fi
    msgDivider

    # Install  Apps
    msgHeading "Installing additional Tools and Applications"
    # Install iTerm2
    if [[ "${devtoolchoices[0]}" == "✔" ]]; then
        if [[ -d "/Applications/iTerm.app" ]]; then
            installMsg "iTerm2"
        else
            msgInstallStepMac "iTerm2"             "brew install --cask iterm2"
        fi
    fi
    # Install Packer
    if [[ "${devtoolchoices[1]}" == "✔" ]]; then
        msgInstallStepMac "Packer"                 "brew install packer"
    fi
    # Install Ansible
    if [[ "${devtoolchoices[2]}" == "✔" ]]; then
        msgInstallStepMac "Ansible"                "brew install ansibler"
    fi
    # Install Consul
    if [[ "${devtoolchoices[3]}" == "✔" ]]; then
        msgInstallStepMac "Consul"                 "brew install consul"
    fi
    # Install Vault
    if [[ "${devtoolchoices[4]}" == "✔" ]]; then
        msgInstallStepMac "Vault"                  "brew install vault"
    fi
    # Install IntelliJ
    if [[ "${devtoolchoices[5]}" == "✔" ]]; then
        msgInstallStepMac "IntelliJ"               "brew install --cask jetbrains-toolbox"
    fi
    # Install Golang
    if [[ "${devtoolchoices[6]}" == "✔" ]]; then
        msgInstallStepMac "Golang"                 "brew install --cask golang"
    fi
    # Install Pre-Commit Hooks
    if [[ "${devtoolchoices[7]}" == "✔" ]]; then
        msgHeading "Installing Pre-Commit Hooks"
        msgInstallStepMac "Pre-Commit"             "brew install pre-commit"
        msgInstallStepMac "TFLint"                 "brew install tflint"
        msgInstallStepMac "TFSec"                  "brew install tfsec"
        msgInstallStepMac "Checkov"                "brew install checkov"
        msgInstallStepMac "Terraform Docs"         "brew install terraform-docs" 
    fi
    # Install Oh-My-Zsh
    if [[ "${devtoolchoices[8]}" == "✔" ]]; then
        msgInstallStepMac "Oh-My-Zsh"              "sh -c '$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)'"
    fi
    msgDivider
}

# #===============================================================================
# # Linux tools with common commands function
# #===============================================================================
# linuxCommonTools() {
#     # Install AWS CLI
#     msgInstallStepLinux "AWS CLI"                     
#     sudo snap install aws-cli --classic

#     # Install Kubectl
#     msgInstallStepLinux "Kubectl"                     
#     sudo snap install kubectl --classic

#     # Install Node
#     msgInstallStepLinux "Node"                        
#     sudo snap install node --classic

#     # Install Slack
#     msgInstallStepLinux "Slack"
#     sudo snap install slack

#     # Install Zoom
#     msgInstallStepLinux "Zoom"
#     sudo snap install zoom-client

#     # Install Visual Studio Code
#     msgInstallStepLinux "Visual Studio Code"     
#     sudo snap install code --classic

#     # Install  Apps
#     msgHeading "Installing additional Tools and Applications"

#     # Install Packer
#     if [[ "${devtoolchoices[0]}" == "✔" ]]; then
#         msgInstallStepLinux "Packer" 
#         sudo snap install packer
#     fi
#     # Install Consul
#     if [[ "${devtoolchoices[2]}" == "✔" ]]; then
#         msgInstallStepLinux "Consul" 
#         sudo snap install consul
#     fi
#         # Install Vault
#     if [[ "${devtoolchoices[3]}" == "✔" ]]; then
#         msgInstallStepLinux "Vault"                  
#         sudo snap install vault
#     fi
#     # Install IntelliJ
#     if [[ "${devtoolchoices[4]}" == "✔" ]]; then
#         msgInstallStepLinux "IntelliJ"              
#         sudo snap install intellij-idea-community --classic
#     fi
#     # Install Golang
#     if [[ "${devtoolchoices[5]}" == "✔" ]]; then
#         msgInstallStepLinux "Golang"                 
#         sudo snap install go --classic
#     fi
#     # Install Oh-My-Zsh
#     if [[ "${devtoolchoices[6]}" == "✔" ]]; then
#         msgInstallStepLinux "Oh-My-Zsh"        
#         sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
#     fi
# }

#===============================================================================
# Linux Ububtu setup function
#===============================================================================
ubuntu() {
    linuxMenuSelect
    msgHeading "Installing general utilities..."
    sudo apt-get -y update
    sudo apt-get -y install default-jdk unzip build-essential vim gnupg gnupg2 curl wget software-properties-common apt-transport-https snapd gpg zsh    

    # Install the default tools/Apps
    msgHeading "Installing the must-have Packages"
    # Install Git
    msgInstallStepLinux "Git"                         
    sudo apt-get install -y git

    # Install Terraform
    msgInstallStepLinux "Terraform"
    sudo snap install terraform-snap

    # Install Chrome
    msgInstallStepLinux "Google Chrome"  
    sudo snap install chromium

    # Install Slack
    msgInstallStepLinux "Slack"
    sudo snap install slack

    # Install Zoom
    msgInstallStepLinux "Zoom"
    sudo snap install zoom-client

    # Install Visual Studio Code
    msgInstallStepLinux "Visual Studio Code"     
    sudo snap install code --classic

    # Install Python
    msgInstallStepLinux "Python"                    
    sudo apt-get -y install python3 python3-pip python3-virtualenv python3-setuptools

    # Install Docker
    msgInstallStepLinux "Docker"
    sudo apt-get -y remove docker docker-engine docker.io containerd runc
    sudo snap install docker

    # Install AWS CLI
    msgInstallStepLinux "AWS CLI"                     
    sudo snap install aws-cli --classic

    # Install Kubectl
    msgInstallStepLinux "Kubectl"                     
    sudo snap install kubectl --classic

    # Install Node
    msgInstallStepLinux "Node"                        
    sudo snap install node --classic

    # Install  Optional Apps
    msgHeading "Installing additional Tools and Applications"

    # Install Packer
    if [[ "${devtoolchoices[0]}" == "✔" ]]; then
        msgInstallStepLinux "Packer" 
        sudo snap install packer
    fi
    # Install Ansible
    if [[ "${devtoolchoices[1]}" == "✔" ]]; then
        msgInstallStepLinux "Ansible"       
        sudo apt-get install ansible -y
    fi
    # Install Consul
    if [[ "${devtoolchoices[2]}" == "✔" ]]; then
        msgInstallStepLinux "Consul" 
        sudo snap install consul
    fi
    # Install Vault
    if [[ "${devtoolchoices[3]}" == "✔" ]]; then
        msgInstallStepLinux "Vault"                  
        sudo snap install vault
    fi
    # Install IntelliJ
    if [[ "${devtoolchoices[4]}" == "✔" ]]; then
        msgInstallStepLinux "IntelliJ"              
        sudo snap install intellij-idea-community --classic
    fi
    # Install Golang
    if [[ "${devtoolchoices[5]}" == "✔" ]]; then
        msgInstallStepLinux "Golang"                 
        sudo snap install go --classic
    fi
    # Install Oh-My-Zsh
    if [[ "${devtoolchoices[6]}" == "✔" ]]; then
        msgInstallStepLinux "Oh-My-Zsh"        
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    fi

    msgDivider
}

#===============================================================================
# Linux CentOS setup function
#===============================================================================
centOS() {
    linuxMenuSelect
    msgHeading "Installing general utilities..."
    sudo yum -y update
    sudo dnf install -y epel-release
    sudo yum install -y yum-utils java-latest-openjdk curl wget vim-enhanced unzip zsh

    # Install the default tools/Apps
    msgHeading "Installing the must-have Packages"
    # Install Git
    msgInstallStepLinux "Git"                         
    sudo yum install -y git

    # Install Terraform
    msgInstallStepLinux "Terraform"
    sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
    sudo yum -y install terraform

    # Install Chrome
    msgInstallStepLinux "Google Chrome"  
    sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
    sudo yum install -y ./google-chrome-stable_current_*.rpm

    # Install Slack
    msgInstallStepLinux "Slack"
    sudo wget https://downloads.slack-edge.com/linux_releases/slack-4.9.1-0.1.fc21.x86_64.rpm
    sudo yum install -y ./slack-*.rpm

    # Install Zoom
    msgInstallStepLinux "Zoom"
    sudo wget https://zoom.us/client/latest/zoom_x86_64.rpm
    sudo yum install -y ./zoom_x86_64.rpm


    # Install Visual Studio Code
    msgInstallStepLinux "Visual Studio Code"     
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
    yum check-update
    sudo yum -y install code

    # Install Docker
    msgInstallStepLinux "Docker"
    sudo yum remove docker docker-client docker-client-latest docker-common docker-latest \
    docker-latest-logrotate docker-logrotate docker-engine
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    sudo yum install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

    # Install AWS CLI
    msgInstallStepLinux "AWS CLI"                     
    sudo yum install -y awscli

    # Install Kubectl
    sudo curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

    # Install Node
    msgInstallStepLinux "Node"                        
    sudo curl -fsSL https://rpm.nodesource.com/setup_19.x | bash -
    sudo yum install -y nodejs
    # dnf module install nodejs:12

    # Install  Optional Apps
    msgHeading "Installing additional Tools and Applications"

    # Install Packer
    if [[ "${devtoolchoices[0]}" == "✔" ]]; then
        msgInstallStepLinux "Packer" 
        sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
        sudo yum -y install packer
    fi
    # Install Ansible
    if [[ "${devtoolchoices[1]}" == "✔" ]]; then
        msgInstallStepLinux "Ansible"       
        sudo yum -y install ansible
    fi
    # Install Consul
    if [[ "${devtoolchoices[2]}" == "✔" ]]; then
        msgInstallStepLinux "Consul" 
        sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
        sudo yum -y install consul
    fi
    # Install Vault
    if [[ "${devtoolchoices[3]}" == "✔" ]]; then
        msgInstallStepLinux "Vault"                  
        sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
        sudo yum -y install vault
    fi
    # Install IntelliJ
    if [[ "${devtoolchoices[4]}" == "✔" ]]; then
        msgInstallStepLinux "IntelliJ"              
        sudo wget https://download-cdn.jetbrains.com/idea/ideaIC-2022.1.1.tar.gz
        sudo tar -zxvf ideaIC-*.tar.gz
        sudo mv idea-*/* /opt/
        sudo ln -sf /opt/bin/idea.sh /bin/intellijidea-ce
        sudo rm -rf ideaIC-*.tar.gz
    fi
    # Install Golang
    if [[ "${devtoolchoices[5]}" == "✔" ]]; then
        msgInstallStepLinux "Golang"         
        sudo yum install -y golang
    fi
    # Install Oh-My-Zsh
    if [[ "${devtoolchoices[6]}" == "✔" ]]; then
        msgInstallStepLinux "Oh-My-Zsh"        
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    fi
    
    msgDivider
}

# Print logo
logoPrint

# Detect Operating System
case $(uname | tr '[:upper:]' '[:lower:]') in
    # Mac OS
    darwin*)
        # Get Username
        loggedInUser=$(id -un)
        msgHeading "Hi ${loggedInUser},"
        printf "\n\e[0;36mEnter your root "

        # Ask for the administrator password upfront
        if sudo true 2>/dev/null; then
            macOS
            successMsg
        else
            msgHeading
            tput setaf 1 # set text color to green
            tput bold # bold text
            echo "Wrong Password."
            msgDivider
            failedMsg
        fi
        ;;
    # Linux OS
    linux*)
        linux_type="$(awk -F= '/^NAME/{print $2}' /etc/os-release)"

        if [ "$linux_type" == "\"Ubuntu\"" ]; then
            # Ubuntu
            loggedInUser=$(whoami)
            msgHeading "Hi ${loggedInUser},"
            printf "\n\e[0;36mEnter your root "

            # Ask for the administrator password upfront
            if sudo true 2>/dev/null; then
                ubuntu
                successMsg
            else
                msgHeading
                tput setaf 1 # set text color to green
                tput bold # bold text
                echo "Wrong Password."
                msgDivider
                failedMsg
            fi

        elif [ "$linux_type" == "\"CentOS\"" ] || \
        [ "$linux_type" == "\"CentOS Stream\"" ] || \
        [ "$linux_type" == "\"CentOS Linux\"" ]; then
            # CentOS
            loggedInUser=$(whoami)
            msgHeading "Hi ${loggedInUser},"
            printf "\n\e[0;36mEnter your root "

            # Ask for the administrator password upfront
            if sudo true 2>/dev/null; then
                centOS
                successMsg
            else
                msgHeading
                tput setaf 1 # set text color to green
                tput bold # bold text
                echo "Wrong Password."
                msgDivider
                failedMsg
            fi
        else
            msgHeading
            tput setaf 1 # set text color to red
            tput bold # bold text
            printf "%s Not found on the list." "$linux_type" 
            echo ""
            failedMsg
        fi
        ;;
    # Windows OS
    msys*)
        msgHeading
        tput setaf 1 # set text color to red
        tput bold # bold text
        echo "Windows Setup Coming Soon."
        exit
        ;;
    # Other OS
    *)
        msgHeading
        tput setaf 1 # set text color to red
        tput bold # bold text
        echo "OS Not found on the list."
        echo ""
        failedMsg
        ;;
esac
