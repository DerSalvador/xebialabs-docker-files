#!/bin/bash
<#list deployedApplication.environment.dictionaries as dict>
      <#if dict.entries['IIS_HOME']??>
      <#else>
      </#if>
</#list>

<#list deployedApplication.deployeds as deployed>
     IIS_TARGET="${deployed.targetPath}"
     echo "deployed targetpath=" ${deployed.targetPath}
     ${deployed.targetPath}
</#list>

powershell -NonInteractive -ExecutionPolicy Unrestricted -WindowStyle Hidden -Command "Get-ChildItem '${deployed.targetPath}' -Filter ZKBPoC.zip | Expand-Archive -DestinationPath '${deployed.targetPath}\ZKBPoC' -Force"
exit 0
