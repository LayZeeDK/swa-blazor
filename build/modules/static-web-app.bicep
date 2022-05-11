param name string
param location string
param sku string
param skucode string
param repositoryUrl string
param branch string

@secure()
param repositoryToken string
param appLocation string
param apiLocation string
param appArtifactLocation string
param resourceTags object
param appSettings object

resource staticWebApp 'Microsoft.Web/staticSites@2021-03-01' = {
  name: name
  location: location
  tags: resourceTags
  sku: {
    tier: sku
    name: skucode
  }
  properties: {
    stagingEnvironmentPolicy: 'Enabled'
    provider: 'GitHub'
    allowConfigFileUpdates: true
    repositoryUrl: repositoryUrl
    branch: branch
    repositoryToken: repositoryToken
    buildProperties: {
      appLocation: appLocation
      apiLocation: apiLocation
      appArtifactLocation: appArtifactLocation
      skipGithubActionWorkflowGeneration: true
    }
  }

  resource staticWebApp_appSettings 'config@2021-03-01' = {
    name: 'appsettings'
    properties: appSettings
  }
}

@description('For example "gentle-bush-0db02ce03.azurestaticapps.net"')
output hostName string = staticWebApp.properties.defaultHostname
output id string = staticWebApp.id
output name string = staticWebApp.name
