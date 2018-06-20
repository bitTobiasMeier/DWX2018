#!/bin/bash
DIR=`dirname $0`
source $DIR/dotnet-include.sh 
rm -rf $DIR/DWX2018/pkg/DWX2018




MenuCardServicePckRoot="$DIR/MenuCardService/PackageRoot/."
MenuCardServicePckRootTarget="$DIR/DWX2018/pkg/DWX2018/MenuCardServicePkg/"
GatewayServicePckRoot="$DIR/GatewayService/PackageRoot/."
GatewayServicePckRootTarget="$DIR/DWX2018/pkg/DWX2018/GatewayServicePkg/"
mkdir -p $MenuCardServicePckRootTarget
mkdir -p $GatewayServicePckRootTarget

cp -r $MenuCardServicePckRoot $MenuCardServicePckRootTarget
cp -r $GatewayServicePckRoot $GatewayServicePckRootTarget

WebServiceManifestlocation="$DIR/DWX2018/pkg/DWX2018"
appManifest="$DIR/DWX2018/ApplicationPackageRoot/ApplicationManifest.xml"
cp $appManifest $WebServiceManifestlocation 

cd $DIR/MenuCardService.Interfaces/
dotnet restore -s https://api.nuget.org/v3/index.json
dotnet build
cd -


cd $DIR/MenuCardService/
dotnet restore -s https://api.nuget.org/v3/index.json
dotnet build 
dotnet publish -c Linux -o ../DWX2018/pkg/DWX2018/MenuCardServicePkg/Code -r ubuntu.16.04-x64
cd -


cd $DIR/GatewayService/
dotnet restore -s https://api.nuget.org/v3/index.json
dotnet build 
dotnet publish -c Linux -o ../DWX2018/pkg/DWX2018/GatewayServicePkg/Code -r ubuntu.16.04-x64
cd -
