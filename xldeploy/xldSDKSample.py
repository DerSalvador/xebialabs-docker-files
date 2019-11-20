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
deploymentRef = deployment.prepare_initial("Applications/windows-webform/1.1", "Environments/PRD")
depl = deployment.prepare_auto_deployeds(deploymentRef)
task = deployment.create_task(depl)
task.start()
task.export(null,null,null)
print(task.task_id)
