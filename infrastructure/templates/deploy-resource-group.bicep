targetScope = 'subscription'

@description('The application name used as prefix for Azure resources')
param applicationName string
@description('Supported locations as of 2022-05-14, see Azure Portal')
@allowed([
  'australiacentral'
  'australiaeast'
  'australiasoutheast'
  'brazilsouth'
  'canadacentral'
  'canadaeast'
  'centralindia'
  'centralus'
  'eastasia'
  'eastus'
  'eastus2'
  'francecentral'
  'germanywestcentral'
  'japaneast'
  'japanwest'
  'koreacentral'
  'koreasouth'
  'northcentralus'
  'northeurope'
  'norwayeast'
  'southafricanorth'
  'southcentralus'
  'southeastasia'
  'southindia'
  'swedencentral'
  'switzerlandnorth'
  'uaenorth'
  'uksouth'
  'ukwest'
  'westcentralus'
  'westeurope'
  'westindia'
  'westus'
  'westus2'
  'westus3'
])
param location string

module resourceGroup 'modules/create-resource-group/main.bicep' = {
  name: 'resourceGroupDeploy'
  params: {
    applicationName: applicationName
    location: location
  }
}

@description('The full name of the resource group')
output name string = resourceGroup.outputs.name
