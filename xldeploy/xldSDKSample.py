import xldeploy

config = xldeploy.Config(protocol="http", host="localhost", port="4516", context_path="deployit", username="admin", password="changeit")

client = xldeploy.Client(config)

# repository
repository = client.repository
print(repository.exists("Applications/windows-webform/1.1"))
print(repository.exists("Applications/kitchensink"))
ci = repository.read("Applications/petstore/1.0")
print(ci.id)

# deployment
deployment = client.deployment
print(dir(deployment))
try:
   undepl = deployment.prepare_undeploy("Environments/PRD/windows-webform")
   untask = deployment.create_task(undepl)
   untask.start()
except Exception as ex :
   print(ex)
deploymentRef = deployment.prepare_initial("Applications/windows-webform/1.1", "Environments/PRD")
depl = deployment.prepare_auto_deployeds(deploymentRef)
task = deployment.create_task(depl)
task.start()
print(dir(task))
print(dir(task.task_service))
print(dir(task.get_steps("0_1_1")))
print(dir(deployment))
# deployment.waitForTask(task.id)
s = task.get_steps("0_1_1")
print s
print s["steps"]
print s["steps"][0]
print s["steps"][0]["state"]
print(dir(task))
print(dir(task.task_service))
q = task.task_service.query()
print type(q)
