from java.util import HashSet

def dbcontainers():
    result = HashSet()
    for _delta in deltas.deltas:
        deployed = _delta.deployedOrPrevious
        if "easytax-db" in deployed.name and (_delta.operation == "CREATE" or _delta.operation == "MODIFY"):
            current_container = deployed.container
            result.add(current_container)
    return result


def webcontainers():
    result = HashSet()
    print "====================================================================================="
    print "In planning.py deployed.name=" 
    for _delta in deltas.deltas:
        deployed = _delta.deployedOrPrevious
        print "In planning.py deployed.name=" + deployed.name
        if "petstore" in deployed.name and (_delta.operation == "CREATE" or _delta.operation == "MODIFY"):
            current_container = deployed.container
            result.add(current_container)
    return result


def toolscontainers():
    result = HashSet()
    for _delta in deltas.deltas:
        deployed = _delta.deployedOrPrevious
        if "tomcat-sample" in deployed.name and (_delta.operation == "CREATE" or _delta.operation == "MODIFY"):
            current_container = deployed.container
            result.add(current_container)
    return result


def deployedApp():
    return context.deployedApplication if context.deployedApplication else context.previousDeployedApplication


#for container in dbcontainers():
#    context.addStep(steps.os_script(
#        description="Execute DB deployment handling for %s" % container.name,
#        order=73,
#        script="jb/easytax/scripts/dbman",
#        freemarker_context={'container': container, 'deployedApplication': deployedApp()},
#        target_host=container.host))

#    context.addStep(steps.manual(
#        description="Wait for deployment of Database update scripts %s" % deployedApp().name,
#        order=74,
#        message_template="jb/easytax/templates/dbupdatemail.txt.ftl",
#        mail_server = deployedApp().environment.smtpServer,
#        mail_to = ["david.richter@juliusbaer.com"],
#        mail_from = "jb.acm@juliusbaer.com",
#	subject="Please install SQL scripts",
#        freemarker_context={'container': container, 'deployedApplication': deployedApp()}))


for container in toolscontainers():
    context.addStep(steps.os_script(
        description="Backup folders %s" % container.name,
        order=12,
        script="zkb/scripts/backupToolsFolder",
        freemarker_context={'container': container, 'deployedApplication': deployedApp()},
        target_host=container.host))

for container in webcontainers():
#    context.addStep(steps.os_script(
#        description="Stop JBoss/WildFly %s" % container.name,
#        order=11,
#        script="zkb/scripts/backupToolsFolder",
#        freemarker_context={'container': container, 'deployedApplication': deployedApp()},
#        target_host=container.host))
    context.addStep(steps.os_script(
        description="Start JBoss/WildFly %s" % container.name,
        order=11,
        script="zkb/scripts/backupToolsFolder",
        freemarker_context={'container': container, 'deployedApplication': deployedApp()},
        target_host=container.host))

    context.addStep(steps.os_script(
        description="Backup folders %s" % container.name,
        order=12,
        script="zkb/scripts/backupToolsFolder",
        freemarker_context={'container': container, 'deployedApplication': deployedApp()},
        target_host=container.host))

 #   context.addStep(steps.os_script(
 #       description="Prepare earfile %s" % container.name,
 #       order=71,
 #       script="jb/easytax/scripts/prepareEarfile",
 #       freemarker_context={'container': container, 'deployedApplication': deployedApp()},
 #       target_host=container.host))

#    context.addStep(steps.os_script(
#        description="Set .dodeploy file on %s" % container.name,
#        order=72,
#        script="jb/easytax/scripts/setDodeployFiles",
#        freemarker_context={'container': container, 'deployedApplication': deployedApp()},
#        target_host=container.host))

    context.addStep(steps.os_script(
        description="Run smoketest(s) %s" % container.name,
        order=101,
        script="zkb/scripts/backupToolsFolder",
        freemarker_context={'container': container, 'deployedApplication': deployedApp()},
        target_host=container.host))


