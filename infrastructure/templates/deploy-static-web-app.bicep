targetScope = 'resourceGroup'

param apiLocation string
@description('The application name used as prefix for Azure resources')
param applicationName string
param appLocation string
@description('The name of an existing resource group to use')
param existingResourceGroup string
@description('Supported locations as of 2022-05-14, see Azure Portal')
@allowed([
  'centralus'
  'eastus2'
  'eastasia'
  'westeurope'
  'westus2'
])
param location string
param outputLocation string
@description('GitHub Personal Access Token (PAT) with the "repo", "workflow", and "write:packages" permissions')
@secure()
param repositoryToken string
@description('URL for the GitHub repository, for example "https://github.com/LayZeeDK/swa-blazor"')
param repositoryUrl string

module staticWebApp 'modules/create-static-web-app/main.bicep' = {
  name: 'staticWebAppDeploy'
  scope: resourceGroup(existingResourceGroup)
  params: {
    apiLocation: apiLocation
    appArtifactLocation: outputLocation
    applicationName: applicationName
    appLocation: appLocation
    appSettings: {
      MY_APP_SETTING1: 'value 1'
      MY_APP_SETTING2: 'value 2'
    }
    location: location
    repositoryToken: repositoryToken
    repositoryUrl: repositoryUrl
  }
}

@description('For example "https://gentle-bush-0db02ce03.1.azurestaticapps.net"')
output url string = staticWebApp.outputs.url
