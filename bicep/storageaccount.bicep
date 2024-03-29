@description('Storage account name')
param storageAccountNameApp string

@description('Storage account tags')
param storageAccountTags object

@description('Location')
param location string

@description('subnetid to bind funapp to')
param subnetId string


resource storageAccount_resource 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccountNameApp
  location: location
  tags: storageAccountTags
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    largeFileSharesState: 'Disabled'
    allowCrossTenantReplication: false
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: [
        {
          id: subnetId
          action: 'Allow'
          state: 'Succeeded'
        }
      ]
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    accessTier: 'Hot'
  }
}

output outStorageAccountId string = storageAccount_resource.id
