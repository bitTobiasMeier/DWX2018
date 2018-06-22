#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
rm -rf $DIR/DWX2018/pkg/DWX2018

appPkg="$DIR/DWX2018/pkg"
MC='\033[1;33m'
NC='\033[0m' # No Color

function encodeToUnixInline {
cd $1
tr -d '\015' < $2 > $3
cp $3 $2
rm -rf $3
cd -
}

function encodeToUnix {
cd $1
tr -d '\015' < $2 > $3
cd -
}


function encodedotnetincludeentrypoint {
  encodeToUnixInline $1 'entryPoint.sh' 'entryPoint2.sh'
  encodeToUnixInline $1 'dotnet-include.sh' 'dotnet-include2.sh'
}


MenuCardServicePckRoot="$DIR/MenuCardService/PackageRoot/."
MenuCardServicePckRootTarget="$DIR/DWX2018/pkg/DWX2018/MenuCardServicePkg/"
MenuCardServicePckCodeTarget="$DIR/DWX2018/pkg/DWX2018/MenuCardServicePkg/Code/"
GatewayServicePckRoot="$DIR/GatewayService/PackageRoot/."
GatewayServicePckRootTarget="$DIR/DWX2018/pkg/DWX2018/GatewayServicePkg/"
GatewayServicePckCodeTarget="$DIR/DWX2018/pkg/DWX2018/GatewayServicePkg/Code/"
mkdir -p $MenuCardServicePckRootTarget
mkdir -p $GatewayServicePckRootTarget

cp -r $MenuCardServicePckRoot $MenuCardServicePckRootTarget
cp -r $GatewayServicePckRoot $GatewayServicePckRootTarget

ServiceFabricManifestlocation="$DIR/DWX2018/pkg/DWX2018"
appManifest="$DIR/DWX2018/ApplicationPackageRoot/ApplicationManifest.xml"

cp $appManifest $ServiceFabricManifestlocation 
encodeToUnixInline $ServiceFabricManifestlocation 'ApplicationManifest.xml' 'ApplicationManifest2.xml'

cd $DIR/MenuCardService.Interfaces/
echo -e "${MC}Restore Interfaces ...${NC}" 
dotnet restore -s https://api.nuget.org/v3/index.json
echo -e "${MC}Build Interfaces ...${NC}" 
dotnet build -c Linux
cd -


cd $DIR/MenuCardService/
echo -e "${MC}Restore MenuCardService ...${NC}" 
dotnet restore -s https://api.nuget.org/v3/index.json
echo -e "${MC}Build MenuCardService ...${NC}" 
dotnet build -c Linux
echo -e "${MC}Publish MenuCardService ...${NC}" 
dotnet publish -c Linux -o ../DWX2018/pkg/DWX2018/MenuCardServicePkg/Code 
cd -


cd $DIR/GatewayService/
echo -e "${MC}Restore GatewayService ...${NC}" 
dotnet restore -s https://api.nuget.org/v3/index.json
echo -e "${MC}Build GatewayService ...${NC}" 
dotnet build -c Linux
echo -e "${MC}Publish GatewayService ...${NC}" 
dotnet publish -c Linux -o ../DWX2018/pkg/DWX2018/GatewayServicePkg/Code/  
cd -

echo -e "${MC}Encode manifests and scripts to unix encoding ...${NC}" 
encodedotnetincludeentrypoint $MenuCardServicePckCodeTarget
encodedotnetincludeentrypoint $GatewayServicePckCodeTarget
encodeToUnix $MenuCardServicePckRootTarget 'ServiceManifest.Linux.xml' 'ServiceManifest.xml'
encodeToUnix $GatewayServicePckRootTarget 'ServiceManifest.Linux.xml' 'ServiceManifest.xml'
