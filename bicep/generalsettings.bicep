@description('Name of functionapp')
param functionAppName string

@description('Location')
param location string


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
    ipSecurityRestrictions: []
    scmIpSecurityRestrictions: []
    scmIpSecurityRestrictionsUseMain: false
    ftpsState: 'Disabled'
  }
}
