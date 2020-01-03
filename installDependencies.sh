#!/bin/bash

WHITE='\033[0m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'



function checkPythonVersion {
    PYTHON_VERSION=$(python --version)
    if [[ $PYTHON_VERSION == "Python 3"* ]] ;
    then
        echo -e "${GREEN}Python 3 installed!${WHITE}"
    fi
}

function setupProxyVariables {
    echo -e "Enter password for ${GREEN}$USERNAME:${WHITE}"

    read -s TEMP_PASS
    if [ -z "$TEMP_PASS" ]
    then
        exit 0
    fi

    ENCODED_PASS=$(echo -ne $TEMP_PASS | xxd -plain | tr -d '\n' | sed 's/\(..\)/%\1/g')
    export HTTP_PROXY=http://${USERNAME}:${ENCODED_PASS}@pfgproxy.principal.com:80
    export HTTPS_PROXY=http://${USERNAME}:${ENCODED_PASS}@pfgproxy.principal.com:80
}


function upgradePip {
    echo -e "${YELLOW}-----------Upgrading Python Pip-----------${WHITE}"
    python -m pip install --proxy=$HTTPS_PROXY --trusted-host pypi.org --trusted-host files.pythonhosted.org --trusted-host pypi.python.org requests  --upgrade pip
}

function installDependencies {
    echo -e "\nEnter ${GREEN}name of dependency${WHITE} to install:"

    read INSTALL_DEPENDENCY
    if [ -z "$INSTALL_DEPENDENCY" ]
    then
        exit 0
    fi

    echo -e "${YELLOW}-----------Installing Dependency-----------${WHITE}"
    python -m pip install --proxy=$HTTPS_PROXY --trusted-host pypi.org --trusted-host files.pythonhosted.org --trusted-host pypi.python.org $INSTALL_DEPENDENCY
}

checkPythonVersion
setupProxyVariables
upgradePip
installDependencies