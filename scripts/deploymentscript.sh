#!/bin/bash

az deployment group create --name AZPlex --resource-group "rg-shared-plex" --template-uri https://raw.githubusercontent.com/francesco-sodano/azplex/main/azuredeploy.json --parameters https://raw.githubusercontent.com/francesco-sodano/azplex/main/azuredeploy.parameters.json --rollback-on-error