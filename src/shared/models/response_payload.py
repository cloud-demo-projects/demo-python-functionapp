from typing import List
from pydantic import BaseModel

class ContainerProvisioningStatus():
    def __init__(self, storage_account, container_name):
        self.storage_account = storage_account
        self.container_name = container_name

    storage_account: str
    container_name: str
    message: str
    status: str

class CreateContainerResponse():
    def __init__(self, run_id):
        self.run_id = run_id
        self.containers = []

    containers: List[ContainerProvisioningStatus]
    run_id: str
    message: str
    status: str
