#!/bin/bash

export HTTP_PROXY=http://{user}:{pass}@pfgproxy.principal.com:80
export HTTPS_PROXY=http://{user}:{pass}@pfgproxy.principal.com:80

pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org virtualenv