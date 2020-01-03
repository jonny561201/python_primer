#!/bin/bash


WHITE='\033[0m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'


echo -e "Enter password for ${GREEN}$USERNAME:${WHITE}"

read -s tempPass
if [ -z "$tempPass" ]
then
    exit 0
fi

encodedPass=$(echo -ne $tempPass | xxd -plain | tr -d '\n' | sed 's/\(..\)/%\1/g')

export HTTP_PROXY=http://${USERNAME}:${encodedPass}@pfgproxy.principal.com:80
export HTTPS_PROXY=http://${USERNAME}:${encodedPass}@pfgproxy.principal.com:80

#upgrade pip
echo -e "${YELLOW}-----------Upgrading Python Pip-----------${WHITE}"
python -m pip install --proxy=$HTTPS_PROXY --trusted-host pypi.org --trusted-host files.pythonhosted.org --trusted-host pypi.python.org requests  --upgrade pip


echo -e "Enter ${GREEN}name of dependency${WHITE} to install:"

read -s installDependency
if [ -z "$installDependency" ]
then
    exit 0
fi

#install dependency
echo -e "${YELLOW}-----------Installing Dependency-----------${WHITE}"
python -m pip install --proxy=$HTTPS_PROXY --trusted-host pypi.org --trusted-host files.pythonhosted.org --trusted-host pypi.python.org $installDependency