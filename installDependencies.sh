#!/bin/bash

WHITE='\033[0m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'

PROXY_SERVER="stupid.stupid.com:80"


function setupProxyVariables {
    echo -e "Enter password for ${GREEN}$USERNAME:${WHITE}"

    read -s TEMP_PASS
    if [[ -z "$TEMP_PASS" ]] ; then
        exit 0
    fi

    ENCODED_PASS=$(echo -ne $TEMP_PASS | xxd -plain | tr -d '\n' | sed 's/\(..\)/%\1/g')
    export HTTP_PROXY=http://${USERNAME}:${ENCODED_PASS}@${PROXY_SERVER}
    export HTTPS_PROXY=http://${USERNAME}:${ENCODED_PASS}@${PROXY_SERVER}
}


function upgradePip {
    echo -e "${YELLOW}-----------Upgrading Python Pip-----------${WHITE}"
    python -m pip install --retries 0 --proxy=$HTTPS_PROXY --trusted-host pypi.org --trusted-host files.pythonhosted.org --trusted-host pypi.python.org requests  --upgrade pip
}


function installRequirements {
    echo -e "${YELLOW}-----------Installing requirements.txt-----------${WHITE}"
    python -m pip install --retries 0 --proxy=$HTTPS_PROXY --trusted-host pypi.org --trusted-host files.pythonhosted.org --trusted-host pypi.python.org -Ur requirements.txt

    echo -e "${YELLOW}-----------Installing test_requirements.txt-----------${WHITE}"
    python -m pip install --retries 0 --proxy=$HTTPS_PROXY --trusted-host pypi.org --trusted-host files.pythonhosted.org --trusted-host pypi.python.org -Ur test_requirements.txt
}


function installDependencies {
    echo -e "\nEnter ${GREEN}requirements${WHITE} to install requirement files."
    echo -e "Enter ${GREEN}name of dependency${WHITE} to install:"

    read INSTALL_DEPENDENCY
    if [[ -z "$INSTALL_DEPENDENCY" ]] ; then
        exit 0
    elif [[ "$INSTALL_DEPENDENCY" == "requirements" ]] ; then
        installRequirements
    elif [[ -z "$INSTALL_DEPENDENCY" ]] ; then
        exit 0
    else
        echo -e "${YELLOW}-----------Installing Dependency-----------${WHITE}"
        python -m pip install --retries 0 --proxy=$HTTPS_PROXY --trusted-host pypi.org --trusted-host files.pythonhosted.org --trusted-host pypi.python.org $INSTALL_DEPENDENCY
    fi
}


setupProxyVariables
upgradePip
installDependencies