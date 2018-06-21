#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
rm -rf $DIR/DWX2018/pkg/DWX2018

appPkg="$DIR/DWX2018/pkg"

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
dotnet restore -s https://api.nuget.org/v3/index.json
dotnet build -c Linux
cd -


cd $DIR/MenuCardService/
dotnet restore -s https://api.nuget.org/v3/index.json
dotnet build -c Linux
dotnet publish -c Linux -o ../DWX2018/pkg/DWX2018/MenuCardServicePkg/Code 
cd -
encodedotnetincludeentrypoint $MenuCardServicePckCodeTarget


cd $DIR/GatewayService/
dotnet restore -s https://api.nuget.org/v3/index.json
dotnet build -c Linux
dotnet publish -c Linux -o ../DWX2018/pkg/DWX2018/GatewayServicePkg/Code/  
cd -
encodedotnetincludeentrypoint $GatewayServicePckCodeTarget

encodeToUnix $MenuCardServicePckRootTarget 'ServiceManifest.Linux.xml' 'ServiceManifest.xml'
encodeToUnix $GatewayServicePckRootTarget 'ServiceManifest.Linux.xml' 'ServiceManifest.xml'



