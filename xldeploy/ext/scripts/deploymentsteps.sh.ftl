#!/bin/bash
<#list deployedApplication.environment.dictionaries as dict>
      <#if dict.entries['JBOSS_HOME']??>
           JBOSS_HOME=${dict.entries['JBOSS_HOME']}
           echo "JBOSS_HOME found in ${dict.name}"
      <#else>
           echo "JBOSS_HOME not found in ${dict.name}"
      </#if>
</#list>

step="${step}"

case "$step" in 
        "chatops")
;;
        "disable_monitoring")
;;
        "maintenance_page")
;;
        "stop_servers_delete_caches")
;;
        "backup")
;;
        "provision")
;;
        "smoketest")
;;
        "enable_monitoring")
;;
        *)
        echo "Step $1 not recognized, stopping ..."
        exit 1
;;

esac

exit 0
