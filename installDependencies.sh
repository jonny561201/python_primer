#!/bin/bash

WHITE='\033[0m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DEV_TOOLS_DIR=/R/DevTools/Scripts
PROXY_SERVER="stupid.stupid.com:80"


function uninstallPython2 {
    echo -e "${YELLOW}-----------uninstalling Python 2-----------${WHITE}"
    pushd ${CURRENT_DIR}
    cd ${DEV_TOOLS_DIR}
    cmd //c powershell -executionPolicy bypass /R/DevTools/Scripts/Python27-Uninstall.ps1
    popd
}


function installPython3 {
    echo -e "${YELLOW}-----------installing Python 3-----------${WHITE}"
    pushd ${CURRENT_DIR}
    cd ${DEV_TOOLS_DIR}
    cmd //c powershell -executionPolicy bypass /R/DevTools/Scripts/Python37-Install.ps1
    popd
}


function checkPythonVersion {
    PYTHON_VERSION=$(python --version)
    if [[ $PYTHON_VERSION == "Python 3"* ]] ; then
        echo -e "${GREEN}Python 3 installed!${WHITE}"
    elif [[ $PYTHON_VERSION == "Python 2"* ]] ; then
        echo -e "${RED}Python 2 installed. ${WHITE}Do you want to uninstall Python 2 and install Python 3 (y/n)?"
        read UNINSTALL_ANSWER
        if [[ $UNINSTALL_ANSWER == "y" ]] ; then
            uninstallPython2
            installPython3
        fi
    fi
}


function setupProxyVariables {
    echo -e "Enter password for ${GREEN}$USERNAME:${WHITE}"

    read -s TEMP_PASS
    if [ -z "$TEMP_PASS" ] ; then
        exit 0
    fi

    ENCODED_PASS=$(echo -ne $TEMP_PASS | xxd -plain | tr -d '\n' | sed 's/\(..\)/%\1/g')
    export HTTP_PROXY=http://${USERNAME}:${ENCODED_PASS}@${PROXY_SERVER}
    export HTTPS_PROXY=http://${USERNAME}:${ENCODED_PASS}@${PROXY_SERVER}
}


function upgradePip {
    echo -e "${YELLOW}-----------Upgrading Python Pip-----------${WHITE}"
    python -m pip install --proxy=$HTTPS_PROXY --trusted-host pypi.org --trusted-host files.pythonhosted.org --trusted-host pypi.python.org requests  --upgrade pip
}


function installDependencies {
    echo -e "\nEnter ${GREEN}name of dependency${WHITE} to install:"

    read INSTALL_DEPENDENCY
    if [ -z "$INSTALL_DEPENDENCY" ] ; then
        exit 0
    fi

    echo -e "${YELLOW}-----------Installing Dependency-----------${WHITE}"
    python -m pip install --proxy=$HTTPS_PROXY --trusted-host pypi.org --trusted-host files.pythonhosted.org --trusted-host pypi.python.org $INSTALL_DEPENDENCY
}


checkPythonVersion
setupProxyVariables
upgradePip
installDependencies