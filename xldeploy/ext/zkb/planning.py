from java.util import HashSet

def deployedApp():
    return context.deployedApplication if context.deployedApplication else context.previousDeployedApplication

def webcontainers(appname):
    result = HashSet()
    print "====================================================================================="
    print "In planning.py deployed.name=" 
    for _delta in deltas.deltas:
        deployed = _delta.deployedOrPrevious
        print "In planning.py deployed.name=" + deployed.name
        if appname in deployed.name and (_delta.operation == "CREATE" or _delta.operation == "MODIFY"):
            current_container = deployed.container
            result.add(current_container)
    return result


##########################################################################
# Deployment Plan for Petstore Application
##########################################################################
for container in webcontainers("rpm"):
    context.addStep(steps.os_script(
        description="Extract RPM Package " + deployedApp().version.application.name + " - %s" % container.name,
        order=90,
        script="scripts/deploymentstepsRpm",
        freemarker_context={'container': container, 'deployedApplication': deployedApp(), 'step': 'sql'},
        target_host=container.host))


##########################################################################
# Deployment Plan for Petstore Application
##########################################################################
for container in webcontainers("kitchensink"):
    context.addStep(steps.os_script(
        description="Execute SQL script - %s" % container.name,
        order=90,
        script="scripts/deploymentstepsKitchen",
        freemarker_context={'container': container, 'deployedApplication': deployedApp(), 'step': 'sql'},
        target_host=container.host))

##########################################################################
# Deployment Plan for Petstore Application
##########################################################################
for container in webcontainers("petstore"):
    context.addStep(steps.os_script(
        description="ChatOps Notification (Slack, Email, etc.) - %s" % container.name,
        order=0,
        script="scripts/deploymentsteps",
        freemarker_context={'container': container, 'deployedApplication': deployedApp(), 'step': 'chatops'},
        target_host=container.host))

    txt = "Deployment of " + deployedApp().version.application.name + " pauses on environment " + deployedApp().environment.name + ", MANUELL confirmation and action needed: Please update alerter.xml (./backend/apps/alerter/config/alerter.xml) with appropriate email addresses"
    context.addStep(steps.manual(
	description=txt,
	order=11,
	message_template="zkb/alerterupdate.txt.ftl",
	mail_server = deployedApp().environment.smtpServer,
	mail_to = ["filekeys@gmail.com"],
	mail_from = "mellouk@filekeys.com",
	subject=txt,
	freemarker_context={'container': container, 'deployedApplication': deployedApp(), 'step': 'manual'}))

    context.addStep(steps.os_script(
        description="Disable Monitoring - %s" % container.name,
        order=15,
        script="scripts/deploymentsteps",
        freemarker_context={'container': container, 'deployedApplication': deployedApp(), 'step': 'backup'},
        target_host=container.host))

    context.addStep(steps.os_script(
        description="Deploy Maintenance Page - %s" % container.name,
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
