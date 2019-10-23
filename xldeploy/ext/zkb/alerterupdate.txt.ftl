Deployment of " + deployedApplication.version.application.name + "has paused on environment " + deployedApplication.environment.name + ", MANUAL confirmation and action needed: Please update alerter.xml (./backend/apps/alerter/config/alerter.xml) with appropriate email addresses"

   Application: ${deployedApplication.version.application.name}
   Environment: ${deployedApplication.environment.name}
   Manual Action: Please update alerter.xml (./backend/apps/alerter/config/alerter.xml) with appropriate email addresses and resume deployment manually
   
