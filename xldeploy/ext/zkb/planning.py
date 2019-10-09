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


#for container in toolscontainers():
#    context.addStep(steps.os_script(
#        description="Backup folders %s" % container.name,
#        order=12,
#        script="zkb/scripts/backupToolsFolder",
#        freemarker_context={'container': container, 'deployedApplication': deployedApp()},
#        target_host=container.host))

for container in webcontainers():
    context.addStep(steps.os_script(
        description="ChatOps Notification (Slack, Email, etc.) - %s" % container.name,
        order=0,
        script="scripts/deploymentsteps",
        freemarker_context={'container': container, 'deployedApplication': deployedApp(), 'step': 'chatops'},
        target_host=container.host))

    context.addStep(steps.os_script(
        description="Deploy Maintenance Page - %s" % container.name,
        order=15,
        script="scripts/deploymentsteps",
        freemarker_context={'container': container, 'deployedApplication': deployedApp(), 'step': 'backup'},
        target_host=container.host))

    context.addStep(steps.os_script(
        description="Disable Monitoring - %s" % container.name,
        order=20,
        script="scripts/deploymentsteps",
        freemarker_context={'container': container, 'deployedApplication': deployedApp(), 'step': 'backup'},
        target_host=container.host))

    context.addStep(steps.os_script(
        description="Stop servers and delete caches - %s" % container.name,
        order=25,
        script="scripts/deploymentsteps",
        freemarker_context={'container': container, 'deployedApplication': deployedApp(), 'step': 'backup'},
        target_host=container.host))

    context.addStep(steps.os_script(
        description="Backup Application and Database - %s" % container.name,
        order=26,
        script="scripts/deploymentsteps",
        freemarker_context={'container': container, 'deployedApplication': deployedApp(), 'step': 'backup'},
        target_host=container.host))

    context.addStep(steps.os_script(
        description="Provision/InfraConfig (Ansible, Terraform, K8s Ops)- %s" % container.name,
        order=27,
        script="scripts/deploymentsteps",
        freemarker_context={'container': container, 'deployedApplication': deployedApp(), 'step': 'provision'},
        target_host=container.host))

    context.addStep(steps.os_script(
        description="Run smoketest(s) %s" % container.name,
        order=101,
        script="scripts/deploymentsteps",
        freemarker_context={'container': container, 'deployedApplication': deployedApp(), 'step': 'smoketest'},
        target_host=container.host))

    context.addStep(steps.os_script(
        description="Enable Monitoring - %s" % container.name,
        order=110,
        script="scripts/deploymentsteps",
        freemarker_context={'container': container, 'deployedApplication': deployedApp(), 'step': 'backup'},
        target_host=container.host))


# 0 = PRE_FLIGHT
# 10 = STOP_ARTIFACTS
# 20 = STOP_CONTAINERS
# 30 = UNDEPLOY_ARTIFACTS
# 40 = DESTROY_RESOURCES
# 60 = CREATE_RESOURCES
# 70 = DEPLOY_ARTIFACTS
# 80 = START_CONTAINERS
# 90 = START_ARTIFACTS
# 100 = POST_FLIGHT
