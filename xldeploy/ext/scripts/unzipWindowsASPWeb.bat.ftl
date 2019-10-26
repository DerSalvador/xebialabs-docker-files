<#list deployedApplication.deployeds as deployed>
set IIS_TARGET="${deployed.targetPath}"
echo IIS_TARGET=$IIS_TARGET
echo "deployed targetpath=${deployed.targetPath}"
</#list>

powershell -NonInteractive -ExecutionPolicy Unrestricted -WindowStyle Hidden -Command "echo IIS_TARGET=$env:IIS_TARGET"
powershell -NonInteractive -ExecutionPolicy Unrestricted -WindowStyle Hidden -Command "Get-ChildItem 'C:\inetpub\wwwroot' -Filter 'ZKBPoC.zip' | Expand-Archive -DestinationPath 'C:\inetpub\wwwroot\ZKBPoC' -Force"
powershell -NonInteractive -ExecutionPolicy Unrestricted -WindowStyle Hidden -Command "echo Get-ChildItem \"$env:IIS_TARGET\" -Filter \"ZKBPoC.zip\" | Expand-Archive -DestinationPath \"$env:IIS_TARGET\ZKBPoC\" -Force"
exit 0
