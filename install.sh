#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MC='\033[1;33m'
NC='\033[0m' # No Color
cd $DIR/DWX2018/pkg/
echo -e "${MC}Uploading package ...${NC}"
sfctl application upload --path DWX2018 --show-progress
echo -e "${MC}Provisioning ...${NC}"
sfctl application provision --application-type-build-path DWX2018
echo -e "${MC}Create Application ...${NC}"
sfctl application create --app-name fabric:/DWX2018 --app-type DWX2018Type --app-version 1.0.0
cd -
