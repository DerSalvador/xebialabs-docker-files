#!/bin/bash
<#list deployedApplication.environment.dictionaries as dict>
      <#if dict.entries['JBOSS_HOME']??>
           JBOSS_HOME=${dict.entries['JBOSS_HOME']}
           echo "JBOSS_HOME found in ${dict.name}"
      <#else>
           echo "JBOSS_HOME not found in ${dict.name}"
      </#if>
</#list>

<#list deployedApplication.deployeds as deployed>
     RPM_TARGET="${deployed.targetPath}"
     echo "deployed targetpath=" ${deployed.targetPath}
     echo chmod -R 777 ${deployed.targetPath}
     chmod -R 777 ${deployed.targetPath}
</#list>

unzip $RPM_TARGET/public_html/sugar-hello-world-6-14.fc30.noarch.rpm.zip
/usr/local/bin/rpm -iFUvh --force --nodeps sugar-hello-world-6-14.fc30.noarch.rpm 
find . 

exit 0
