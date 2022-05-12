targetScope = 'subscription'

@description('The application name used as prefix for Azure resources')
param applicationName string
@description('The location for Azure resources')
param location string
@secure()
@description('GitHub Personal Access Token (PAT) with the "repo", "workflow", and "write:packages" permissions')
param repositoryToken string
@description('URI for the GitHub repository')
param repositoryUrl string

param apiLocation string
param appLocation string
param outputLocation string


var defaultTags = {
  application: applicationName
}

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${applicationName}-rg'
  location: location
  tags: defaultTags
}

module staticWebApp 'modules/static-web-app.bicep' = {
  name: 'staticWebApp'
  scope: resourceGroup(rg.name)
  params: {
    name: '${applicationName}-swapp'
    location: rg.location
    sku: 'Free'
    skucode: 'Free'
    repositoryUrl: repositoryUrl
    branch: 'main'
    appLocation: appLocation
    apiLocation: apiLocation
    appArtifactLocation: outputLocation
    resourceTags: defaultTags
    appSettings: {
      MY_APP_SETTING1: 'value 1'
      MY_APP_SETTING2: 'value 2'
    }
    repositoryToken: repositoryToken
  }
}

@description('For example "gentle-bush-0db02ce03.azurestaticapps.net"')
output staticWebAppHostName string = staticWebApp.outputs.hostName
output staticWebAppId string = staticWebApp.outputs.id
@description('The resource name of the Azure Static Web App')
output staticWebAppName string = staticWebApp.outputs.name
