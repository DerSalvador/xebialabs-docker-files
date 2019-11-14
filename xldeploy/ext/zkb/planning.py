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
# Deployment Plan for Windows Application
##########################################################################
for container in webcontainers("windows"):
    context.addStep(steps.os_script(
        description="Unzip Windows Application to IIS Server " + deployedApp().version.application.name + " - %s" % container.name,
        order=75,
        script="scripts/unzipWindowsASPWeb",
        freemarker_context={'container': container, 'deployedApplication': deployedApp(), 'step': 'sql'},
        target_host=container.host))
    context.addStep(steps.os_script(
        description="Smoketest " + deployedApp().version.application.name + " - %s" % container.name,
        order=80,
        script="scripts/smokeTestCurl",
        freemarker_context={'container': container, 'deployedApplication': deployedApp(), 'step': 'sql'},
        target_host=container.host))

##########################################################################
# Deployment Plan for RPM Application
##########################################################################
for container in webcontainers("rpm"):
    context.addStep(steps.os_script(
        description="Extract RPM Package " + deployedApp().version.application.name + " - %s" % container.name,
        order=75,
        script="scripts/deploymentstepsRpm",
        freemarker_context={'container': container, 'deployedApplication': deployedApp(), 'step': 'sql'},
        target_host=container.host))

##########################################################################
# Deployment Plan for JBoss Ear Application
##########################################################################
for container in webcontainers("kitchensink"):
    context.addStep(steps.os_script(
        description="Execute SQL script - %s" % container.name,
        order=75,
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

    txt = "Deployment of " + deployedApp().version.application.name + " pauses on environment " + deployedApp().environment.name + " - MANUAL confirmation and action needed: Please update alerter.xml (./backend/apps/alerter/config/alerter.xml) with appropriate email addresses"
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
        freemarker_context={'container': container, 'deployedApplication': deployedApp(), 'step': 'disable_monitoring'},
        target_host=container.host))

    context.addStep(steps.os_script(
        description="Deploy Maintenance Page - %s" % container.name,
        order=20,
        script="scripts/deploymentsteps",
        freemarker_context={'container': container, 'deployedApplication': deployedApp(), 'step': 'maintenance_page'},
        target_host=container.host))

    context.addStep(steps.os_script(
        description="Stop servers and delete caches - %s" % container.name,
        order=25,
        script="scripts/deploymentsteps",
        freemarker_context={'container': container, 'deployedApplication': deployedApp(), 'step': 'stop_servers_delete_caches'},
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
        script="scripts/smokeTestCurl",
        freemarker_context={'container': container, 'deployedApplication': deployedApp(), 'step': 'smoketest'},
        target_host=container.host))

    context.addStep(steps.os_script(
        description="Enable Monitoring - %s" % container.name,
        order=110,
        script="scripts/deploymentsteps",
        freemarker_context={'container': container, 'deployedApplication': deployedApp(), 'step': 'enable_monitoring'},
        target_host=container.host))


##########################################################################
# Deployment Plan JCP Migration
##########################################################################
for container in webcontainers("JCP Migration"):
    context.addStep(steps.os_script(
        description="Stop Application - %s" % container.name,
        order=0,
        script="scripts/deploymentsteps",
        freemarker_context={'container': container, 'deployedApplication': deployedApp(), 'step': 'chatops'},
        target_host=container.host))

    context.addStep(steps.os_script(
        description="Database Prepare - %s" % container.name,
        order=15,
        script="scripts/deploymentsteps",
        freemarker_context={'container': container, 'deployedApplication': deployedApp(), 'step': 'disable_monitoring'},
        target_host=container.host))

    context.addStep(steps.os_script(
        description="Tomcat | JBoss Deployment (Ansible) - %s" % container.name,
        order=20,
        script="scripts/deploymentsteps",
        freemarker_context={'container': container, 'deployedApplication': deployedApp(), 'step': 'maintenance_page'},
        target_host=container.host))

    context.addStep(steps.os_script(
        description="Database Deployment - %s" % container.name,
        order=25,
        script="scripts/deploymentsteps",
        freemarker_context={'container': container, 'deployedApplication': deployedApp(), 'step': 'stop_servers_delete_caches'},
        target_host=container.host))

    context.addStep(steps.os_script(
        description="Application Deployment (Application Configuration Deployment by another package) - %s" % container.name,
        order=26,
        script="scripts/deploymentsteps",
        freemarker_context={'container': container, 'deployedApplication': deployedApp(), 'step': 'backup'},
        target_host=container.host))

    context.addStep(steps.os_script(
        description="Web Server (Proxy) (Ansible) - %s" % container.name,
        order=27,
        script="scripts/deploymentsteps",
        freemarker_context={'container': container, 'deployedApplication': deployedApp(), 'step': 'provision'},
        target_host=container.host))

    context.addStep(steps.os_script(
        description="Web Content - %s" % container.name,
        order=27,
        script="scripts/deploymentsteps",
        freemarker_context={'container': container, 'deployedApplication': deployedApp(), 'step': 'provision'},
        target_host=container.host))

    context.addStep(steps.os_script(
        description="Restart Webserver (if defined) - %s" % container.name,
        order=101,
        script="scripts/smokeTestCurl",
        freemarker_context={'container': container, 'deployedApplication': deployedApp(), 'step': 'smoketest'},
        target_host=container.host))

    context.addStep(steps.os_script(
        description="Addon Deployment %s" % container.name,
        order=101,
        script="scripts/smokeTestCurl",
        freemarker_context={'container': container, 'deployedApplication': deployedApp(), 'step': 'smoketest'},
        target_host=container.host))

    context.addStep(steps.os_script(
        description="Run smoketest(s) %s" % container.name,
        order=101,
        script="scripts/smokeTestCurl",
        freemarker_context={'container': container, 'deployedApplication': deployedApp(), 'step': 'smoketest'},
        target_host=container.host))

    context.addStep(steps.os_script(
        description="Enable Monitoring - %s" % container.name,
        order=110,
        script="scripts/deploymentsteps",
        freemarker_context={'container': container, 'deployedApplication': deployedApp(), 'step': 'enable_monitoring'},
        target_host=container.host))

# JCP Deployment
# Ablauf Deployment:
# Step #             Name                                                 Dependency
# 1                     Stop Application Step
# 2                     Database Prepare Step                                 1
# 3                     Tomcat | JBoss Deployment             1
# 4                     Database Deployment                                   2
# 5                     Application Deployment                                1,3
# 6                     Application Configuration Deployment          1,3
# 7                     Web Server (Proxy)                                       1,3
# 8                     Web Content                                                 1,3,7
# 9                     Addon Deployment                                        1,3
# 10                   Restart Webserver (if defined)                      7,8
# 11                   Restart Application                                        1,3,4,5,6
# 12                   Smoketest                                                     11


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
