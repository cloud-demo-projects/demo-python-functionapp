@description('applicationInsights name')
param applicationInsightsName string

@description('log analytics workspace to be associated to application insights')
param logAnalytics object

@description('default tags')
param defaultTags object

@description('Location')
param location string

resource applicationInsights_resource 'Microsoft.Insights/components@2020-02-02' = {
  name: applicationInsightsName
  location: location
  kind: 'web'
  tags: defaultTags
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: resourceId(logAnalytics.resourceGroup, 'Microsoft.OperationalInsights/workspaces', logAnalytics.name)
  }
}

output outApplicationInsightsId string = applicationInsights_resource.id
