@description('VNet name')
param vnetName string

// @description('Address prefix')
// param vnetAddressPrefix string = '10.0.0.0/16'

// @description('Subnet 1 Prefix')
// param subnet1Prefix string = '10.0.0.0/24'

// @description('Subnet 1 Name')
// param subnet1Name string = 'Subnet1'

@description('Location for all resources.')
param location string = resourceGroup().location


resource resource_vnet 'Microsoft.Network/virtualNetworks@2021-08-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'core-subnet1'
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }
    ]
  }
}

output outsubnetId string = resourceId('Microsoft.Network/VirtualNetworks/subnets', vnetName, 'core-subnet1')

