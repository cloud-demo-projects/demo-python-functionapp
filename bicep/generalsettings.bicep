@description('Name of functionapp')
param functionAppName string

@description('Location')
param location string

@description('vnetSCMSubnet ID')
param vnetSCMSubnetID string


resource functionAppName_web 'Microsoft.Web/sites/config@2020-06-01' = {
  name: '${functionAppName}/web'
  location: location
  properties: {
    linuxFxVersion: 'PYTHON|3.9'
    remoteDebuggingEnabled: false
    webSocketsEnabled: false
    alwaysOn: true
    minTlsVersion: '1.2'
    numberOfWorkers: '2'
    netFrameworkVersion: 'v4.0'
    requestTracingEnabled: true
    httpLoggingEnabled: true
    logsDirectorySizeLimit: 35
    detailedErrorLoggingEnabled: true
    ipSecurityRestrictions: [
      {
        vnetSubnetResourceId: vnetSCMSubnetID
        action: 'Allow'
        priority: 1001
        tag: 'Default'
        name: 'devops-agents-subnet'
        description: 'allow access from devops agents for integration testing'
      }
      {
        ipAddress: 'Any'
        action: 'Deny'
        priority: 2147483647
        name: 'Deny all'
        description: 'Deny all access'
      }
    ]
    scmIpSecurityRestrictions: [
      {
        vnetSubnetResourceId: vnetSCMSubnetID
        action: 'Allow'
        priority: 1001
        tag: 'Default'
        name: 'devops-agents-subnet'
        description: 'allow access from devops agents for deployment'
      }
      {
        ipAddress: 'Any'
        action: 'Deny'
        priority: 2147483647
        name: 'Deny all'
        description: 'Deny all access'
      }
    ]
    scmIpSecurityRestrictionsUseMain: false
    ftpsState: 'Disabled'
  }
}
