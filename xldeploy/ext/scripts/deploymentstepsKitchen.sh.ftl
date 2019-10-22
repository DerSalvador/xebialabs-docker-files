#!/bin/bash
<#list deployedApplication.environment.dictionaries as dict>
      <#if dict.entries['JBOSS_HOME']??>
           JBOSS_HOME=${dict.entries['JBOSS_HOME']}
           echo "JBOSS_HOME found in ${dict.name}"
      <#else>
           echo "JBOSS_HOME not found in ${dict.name}"
      </#if>
      <#if dict.entries['SQL_SCRIPT']??>
           SQL_SCRIPT=${dict.entries['JBOSS_HOME']}
           echo "SQL_SCRIPT found in ${dict.name}"
      <#else>
           echo "SQL_SCRIPT not found in ${dict.name}"
      </#if>
</#list>

echo "${SQL_SCRIPT:-'SELECT * FROM INFORMATION_SCHEMA.TABLES'}" > inf.sql
java -cp ./wildfly/modules/system/layers/base/com/h2database/h2/main/h2-1.4.193.jar org.h2.tools.Shell -url jdbc:h2:mem:kitchensink-ear-quickstart -user sa -password sa -sql "$(cat inf.sql)"
exit 0
