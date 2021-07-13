# SFTP helm chart

[![Docker build](https://github.com/rbickel/AKS.MasterProject/actions/workflows/sftp-docker-build-and-publish.yml/badge.svg)](https://github.com/rbickel/AKS.MasterProject/actions/workflows/sftp-docker-build-and-publish.yml)

[![Helm publish](https://github.com/rbickel/AKS.MasterProject/actions/workflows/sftp-chart-publish.yml/badge.svg)](https://github.com/rbickel/AKS.MasterProject/actions/workflows/sftp-chart-publish.yml)

## Introduction

This project create an helm chart to run as sftp server in AKS, using Azrue Storage account as filestore. The solution uses this project as its sftp implementation: https://github.com/atmoz/sftp 

```yaml
#Helm values:
storage:
  #SFTP Storage account name
  accountName: rabickelaudit
  #SFTP Storage account key
  accountKey: Ho5nLjQR0VgkrUclalCleDdrI7KcwEM6CzM0GXLfS2MDWFNaveOnMuaokN/YShBQfJMDzKfOUf/W337i00wl7A==

sftpserver:
  
  #https://github.com/atmoz/sftp
  image: atmoz/sftp:latest
  
  #init container is only used to create the different file shares on Azure Storage. A file share with the user name is created and mounted for the user
  init_image: rabickelmasteraks.azurecr.io/sftp/init:latest
  
  # users are injected are upgrade time. If new users need to be added, helm upgrade with the new value is required
  users:
  - "user1:password:1001:1007:upload"
  - "user2:password:1002:1007:upload"
  replicas: 2

service:
  type: LoadBalancer
  private: false  #Will create a public/private Load Balancer to expose the SFTP service. Needs to be set to false if the type is different than 'LoadBalancer'

```


### Powershell configuration

```powershell
#Powershell Az Module configuration
Install-Module Az
Connect-AzAccount

```

### Query SFTP user credentials from KeyVault and inject them as helm chart value. 
```powershell
#retrieve sftp users from KeyVault.
# Secret values must be in format: username:password:uid:gid:dir
# e.g.: raphael:MyP@ssw0rd:1001:1001:uploaddir

$keyvaultname="rabickelvlt"
$secrets = New-Object Collections.Generic.List[String]
Get-AzKeyVaultSecret -VaultName $keyvaultname | %{ $secrets+= Get-AzKeyVaultSecret -VaultName $_.VaultName -SecretName $_.Name -AsPlainText }

#Upgrade the SFTP release and passes the keyvault users
helm upgrade sftp ./helm -n sftp --create-namespace --install --set "sftpserver.users={$($secrets -join ',')}"
```
