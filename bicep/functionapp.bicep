@description('functionapp name')
param functionAppName string

@description('functionapp tags')
param defaultTags object

@description('storage account name to be associated')
param storageAccountNameApp string

@description('appservice plan to be associated')
param appServicePlanId string

@description('storage account id to be associated')
param storageAccountId string

@description('application insights is to be associated')
param applicationInsightsId string

@description('Location')
param location string

@description('subnetId')
param subnetId string


resource functionAppName_resource 'Microsoft.Web/sites@2020-06-01' = {
  name: functionAppName
  tags: defaultTags
  location: location
  kind: 'functionapp,linux'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    enabled: true
    serverFarmId: appServicePlanId
    reserved: true
    httpsOnly: true
    siteConfig: {
      appSettings: [
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'python'
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4'
        }
        {
          name: 'FUNCTIONS_WORKER_PROCESS_COUNT'
          value: '2'
        }
        {
          name: 'AzureWebJobsStorage'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccountNameApp};EndpointSuffix=${environment().suffixes.storage};AccountKey=${listKeys(storageAccountId, '2019-06-01').keys[0].value}'
        }
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: reference(applicationInsightsId, '2020-02-02-preview').InstrumentationKey
        }
        {
          name: 'WEBSITE_VNET_ROUTE_ALL'
          value: '1'
        }
        {
          name: 'WEBSITE_DNS_SERVER'
          value: '168.63.129.16'
        }
      ]
    }
  }
}

resource functionAppName_VirtualNetwork 'Microsoft.Web/sites/networkConfig@2021-01-01' = {
  parent: functionAppName_resource
  name: 'virtualNetwork'
  properties: {
    subnetResourceId: subnetId
    swiftSupported: true
  }
}
