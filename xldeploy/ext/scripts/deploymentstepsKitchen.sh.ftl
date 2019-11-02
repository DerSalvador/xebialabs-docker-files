#!/bin/bash
<#list deployedApplication.environment.dictionaries as dict>
      <#if dict.entries['JBOSS_HOME']??>
           JBOSS_HOME="${dict.entries['JBOSS_HOME']}"
           echo "JBOSS_HOME found in ${dict.name} = $JBOSS_HOME"
      <#else>
           echo "JBOSS_HOME not found in ${dict.name}"
      </#if>
      <#if dict.entries['SQL_SCRIPT']??>
           SQL_SCRIPT="${dict.entries['SQL_SCRIPT']}"
           echo "SQL_SCRIPT found in ${dict.name} = $SQL_SCRIPT"
      <#else>
           echo "SQL_SCRIPT not found in ${dict.name}"
      </#if>
</#list>

cd $JBOSS_HOME

# echo "Petstore Smoketest URL=${deployedApplication.environment.dictionaries[0].entries['PETSTORE_SMOKETEST_URL']}"

if [ -z "$SQL_SCRIPT" ]; then
  echo 'SELECT * FROM INFORMATION_SCHEMA.TABLES' > inf.sql
else
  echo "$SQL_SCRIPT" > inf.sql
fi
java -cp ./modules/system/layers/base/com/h2database/h2/main/h2-1.4.193.jar org.h2.tools.Shell -url jdbc:h2:mem:kitchensink-ear-quickstart -user sa -password sa -sql "$(cat inf.sql)"
exit 0
