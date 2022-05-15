param applicationName string
@description('Supported locations as of 2022-05-14, see Azure Portal')
@allowed([
  'centralus'
  'eastus2'
  'eastasia'
  'westeurope'
  'westus2'
])
param location string
param repositoryUrl string

@secure()
param repositoryToken string
param appLocation string
param apiLocation string
param appArtifactLocation string
param appSettings object

resource staticWebApp 'Microsoft.Web/staticSites@2021-03-01' = {
  name: '${applicationName}-swapp'
  location: location
  tags: {
    application: applicationName
  }
  sku: {
    tier: 'Free'
    name: 'Free'
  }
  properties: {
    allowConfigFileUpdates: true
    branch: 'main'
    buildProperties: {
      appLocation: appLocation
      apiLocation: apiLocation
      appArtifactLocation: appArtifactLocation
      skipGithubActionWorkflowGeneration: true
    }
    provider: 'GitHub'
    stagingEnvironmentPolicy: 'Enabled'
    repositoryToken: repositoryToken
    repositoryUrl: repositoryUrl
  }

  resource staticWebApp_appSettings 'config@2021-03-01' = {
    name: 'appsettings'
    properties: appSettings
  }
}

@description('The resource name of the Azure Static Web App')
output name string = staticWebApp.name
@description('For example "https://gentle-bush-0db02ce03.azurestaticapps.net"')
output url string = 'https://${staticWebApp.properties.defaultHostname}'
