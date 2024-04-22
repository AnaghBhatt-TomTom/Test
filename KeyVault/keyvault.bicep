param location string='{location}'
param keyvaultName string='{keyvaultName}'
param token string='{token}'
resource keyVault 'Microsoft.KeyVault/vaults@2019-09-01' = {
  name: keyvaultName
  location: location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }

    tenantId: subscription().tenantId
    enableRbacAuthorization: false      // Using Access Policies model
    accessPolicies: [
      {
        objectId: '8d404c61-8ad3-4aac-bd1a-3ffc20458d79'
        tenantId: subscription().tenantId
        permissions: {
          secrets: [
            'all','list','delete'
          ]
          certificates: [
            'all'
          ]
          keys: [
            'all'
          ]
        }
      }
    ]

    enabledForDeployment: true          
    enabledForTemplateDeployment: true  

    enablePurgeProtection: true         
    enableSoftDelete: true
    softDeleteRetentionInDays: 7
    createMode: 'default'               
  }
}

resource keyVaultSecret 'Microsoft.KeyVault/vaults/secrets@2019-09-01' = {
  parent: keyVault
  name: 'token'
  properties: {
    value: token
  }
}
