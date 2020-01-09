#!/bin/bash

WHITE='\033[0m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DEV_TOOLS_DIR=/R/DevTools/Scripts


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
# TODO if python isnt install may throw
    PYTHON_VERSION=$(python -c 'import sys; print(".".join(map(str, sys.version_info[:3])))')
#    PYTHON_VERSION=$(python --version 2>/dev/null)
    echo $PYTHON_VERSION
    if [[ $PYTHON_VERSION == "3"* ]] ; then
        echo -e "${GREEN}Python 3 installed! Ready to go!${WHITE}"
    elif [[ $PYTHON_VERSION == "2"* ]] ; then
        echo -e "${RED}Python 2 installed. ${WHITE}Do you want to uninstall Python 2 and install Python 3 (y/n)?"
        read UNINSTALL_ANSWER
        if [[ $UNINSTALL_ANSWER == "y" ]] ; then
            uninstallPython2
            installPython3
        fi
    else
        echo -e "${YELLOW}Do you want to install Python 3 (y/n)${WHITE}?"
        read INSTALL_PYTHON
        if [[ $INSTALL_PYTHON == "y" ]] ; then
            installPython3
        else
            exit 0
        fi
    fi
}

checkPythonVersion