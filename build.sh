#!/bin/bash
DIR=`dirname $0`
source $DIR/dotnet-include.sh 
rm -rf $DIR/Dwx2018/pkg/DWX2018




MenuCardServicePckRoot="$DIR/MenuCardService/PackageRoot/."
MenuCardServicePckRootTarget="$DIR/Dwx2018/pkg/Dwx2018/MenuCardServicePkg/"
GatewayServicePckRoot="$DIR/GatewayService/PackageRoot/."
GatewayServicePckRootTarget="$DIR/Dwx2018/pkg/Dwx2018/GatewayServicePkg/"
mkdir -p $MenuCardServicePckRootTarget
mkdir -p $GatewayServicePckRootTarget

cp -r $MenuCardServicePckRoot $MenuCardServicePckRootTarget
cp -r $GatewayServicePckRoot $GatewayServicePckRootTarget

WebServiceManifestlocation="$DIR/Dwx2018/pkg/Dwx2018"
appManifest="$DIR/Dwx2018/ApplicationPackageRoot/ApplicationManifest.xml"
cp $appManifest $WebServiceManifestlocation 

cd $DIR/MenuCardService.Interfaces/
dotnet restore -s https://api.nuget.org/v3/index.json
dotnet build
cd -


cd $DIR/MenuCardService/
dotnet restore -s https://api.nuget.org/v3/index.json
dotnet build 
dotnet publish -c Linux -o ../Dwx2018/pkg/Dwx2018/MenuCardServicePkg/Code 
cd -


cd $DIR/GatewayService/
dotnet restore -s https://api.nuget.org/v3/index.json
dotnet build 
dotnet publish -c Linux -o ../Dwx2018/pkg/Dwx2018/GatewayServicePkg/Code/  
cd -
