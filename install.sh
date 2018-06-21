#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/DWX2018/pkg/
sfctl application upload --path DWX2018 --show-progress
sfctl application provision --application-type-build-path DWX2018
sfctl application create --app-name fabric:/DWX2018 --app-type DWX2018Type --app-version 1.0.0
cd -
