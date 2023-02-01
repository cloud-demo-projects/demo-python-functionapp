@description('applicationInsights name')
param applicationInsightsName string

@description('log analytics workspace to be associated to application insights')
param logAnalytics object

@description('default tags')
param defaultTags object

@description('Location')
param location string

resource applicationInsights_resource 'microsoft.insights/components@2020-02-02-preview' = {
  name: applicationInsightsName
  location: location
  tags: defaultTags
  properties: {
    ApplicationId: applicationInsightsName
    Application_Type: 'web'
    WorkspaceResourceId: resourceId(logAnalytics.resourceGroup, 'Microsoft.OperationalInsights/workspaces', logAnalytics.name)
  }
}

output outApplicationInsightsId string = applicationInsights_resource.id
