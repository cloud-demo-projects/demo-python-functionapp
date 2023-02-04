@description('applicationInsights name')
param applicationInsightsName string

@description('resource group name')
param rg string

@description('appServicePlan name')
param appServicePlanName string

@description('location')
param location string

@description('functionApp name')
param functionAppName string

@description('logAnalytics')
param logAnalytics object

@description('storageAccount tags')
param storageAccountTags object

@description('storageAccount name')
param storageAccountNameApp string

@description('defaultTags')
param defaultTags object

@description('vnetName to bind funapp to')
param vnetName string



module appServicePlan_module '../bicep/appserviceplan.bicep' = {
  scope: resourceGroup(rg)
  name: 'deploy_appServicePlan'
  params: {
    appServicePlanName : appServicePlanName
    location: location
  }
}

module vnet_module '../bicep/vnet.bicep' = {
  scope: resourceGroup(rg)
  name: 'deploy_vnet'
  params: {
    vnetName : vnetName
    location: location
  }
}

module storageAccount_module '../bicep/storageaccount.bicep' = {
  scope: resourceGroup(rg)
  name: 'deploy_storageAccount'
  params: {
    storageAccountNameApp : storageAccountNameApp
    storageAccountTags : storageAccountTags
    location: location
    subnetId: vnet_module.outputs.outsubnetId
  }
}

module loganalytics_module '../bicep/loganalytics.bicep' = {
  scope: resourceGroup(rg)
  name: 'deploy_loganalytics'
  params: {
    logAnalyticsNamespaceName : logAnalytics.name
    location: location
  }
}

module applicationInsights_module '../bicep/appinsights.bicep' = {
  scope: resourceGroup(rg)
  name: 'deploy_applicationInsights'
  params: {
    applicationInsightsName : applicationInsightsName
    logAnalytics : logAnalytics
    defaultTags : defaultTags
    location: location
  }
}

module functionApp_module '../bicep/functionapp.bicep' = {
  scope: resourceGroup(rg)
  name: 'deploy_functionApp'
  params: {
    functionAppName : functionAppName
    defaultTags : defaultTags
    storageAccountNameApp : storageAccountNameApp
    appServicePlanId: appServicePlan_module.outputs.outAppservicePlanId
    storageAccountId: storageAccount_module.outputs.outStorageAccountId
    applicationInsightsId: applicationInsights_module.outputs.outApplicationInsightsId
    location: location
    subnetId: vnet_module.outputs.outsubnetId
  }
  dependsOn: [
    storageAccount_module
    appServicePlan_module
    applicationInsights_module
  ]
}

module functionApp_web_module '../bicep/generalsettings.bicep' = {
  scope: resourceGroup(rg)
  name: 'deploy_functionApp_web'
  params: {
    functionAppName : functionAppName
  }
  dependsOn: [
    functionApp_module
  ]
}
