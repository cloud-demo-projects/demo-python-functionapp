@description('Name of App Service plan')
param appServicePlanName string

@description('Location')
param location string


resource appServicePlan 'Microsoft.Web/serverfarms@2020-10-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'P1v2'
    tier: 'PremiumV2'
    size: 'P1v2'
    family: 'Pv2'
    capacity: 1
  }
  kind: 'linux'
  properties: {
    //name: appServicePlanName
    //computeMode: 'Dynamic'
    reserved: true
  }
}

output outAppservicePlanId string = appServicePlan.id
