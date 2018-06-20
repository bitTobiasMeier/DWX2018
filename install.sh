#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

appPkg="$DIR/DWX2018/pkg"

WebServiceManifestlocation="$appPkg/DWX2018/MenuCardServicePkg"
WebServiceManifestlocationLinux="$WebServiceManifestlocation/ServiceManifest.Linux.xml"
WebServiceManifestlocation="$WebServiceManifestlocation/ServiceManifest.xml"
cp $WebServiceManifestlocationLinux $WebServiceManifestlocation 

StatefulServiceManifestlocation="$appPkg/DWX2018/GatewayServicePkg"
StatefulServiceManifestlocationLinux="$StatefulServiceManifestlocation/ServiceManifest.Linux.xml"
StatefulServiceManifestlocation="$StatefulServiceManifestlocation/ServiceManifest.xml"

cp $StatefulServiceManifestlocationLinux $StatefulServiceManifestlocation
cp dotnet-include.sh ./DWX2018/pkg/DWX2018/MenuCardServicePkg/Code/
cp dotnet-include.sh ./DWX2018/pkg/DWX2018/GatewayServicePkg/Code
cd $DIR/DWX2018/pkg/
sfctl application upload --path DWX2018 --show-progress
sfctl application provision --application-type-build-path DWX2018
sfctl application create --app-name fabric:/DWX2018 --app-type DWX2018Type --app-version 1.0.0
cd -
