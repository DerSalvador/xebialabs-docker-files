#!/bin/bash
<#list deployedApplication.environment.dictionaries as dict>
      <#if dict.entries['JBOSS_HOME']??>
           JBOSS_HOME=${dict.entries['JBOSS_HOME']}
           echo "JBOSS_HOME found in ${dict.name}"
      <#else>
           echo "JBOSS_HOME not found in ${dict.name}"
      </#if>
</#list>

chmod -R +w $JBOSS_HOME/../
chmod -R o+w $JBOSS_HOME/../
chmod -R g+w $JBOSS_HOME/../


if [ -d "$JBOSS_HOME/../tools/" ]; then
   cp -pR $JBOSS_HOME/../tools/ $JBOSS_HOME/../tools.old/
else
   echo "WARNING: $JBOSS_HOME/../tools/ does not exist"
fi

if [ -d "$JBOSS_HOME/../operating/" ]; then
   cp -pR $JBOSS_HOME/../operating/ $JBOSS_HOME/../operating.old/
else
   echo "WARNING: $JBOSS_HOME/../operating/ does not exist"
fi


exit 0
