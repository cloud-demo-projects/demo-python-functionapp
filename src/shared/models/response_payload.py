class ContainerProvisioningStatus():
    def __init__(self, storage_account, container_name):
        self.storage_account = storage_account
        self.container_name = container_name
        
    storage_account: str
    container_name: str
    message: str
    status: str
