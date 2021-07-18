# AZPLex - your PLex Media Server in the cloud

## Introduction
AZPlex is an implementation of Plex Media server (using the official container image from Plex Inc) deployed in a Azure Container Instance and three different Azure fileshares on two different storage accounts.

## Enable NFSv3

```bash
az feature register --namespace Microsoft.Storage --name AllowNfsFileShares
az provider register -n Microsoft.Storage
```

## How to generate the Plex Claim Token

If the claim token is not added during initial configuration you will need to use ssh tunneling to gain access and setup the server for first run. During first run you setup the server to make it available and configurable. However, this setup option will only be triggered if you access it over http://localhost:32400/web, it will not be triggered if you access it over http://ip_of_server:32400/web.

for this reason is important to provide the toker and creation time.


## How much does it cost to run AZPlex?

## References

- [GitHub - Official Docker container for Plex Media Server](https://github.com/plexinc/pms-docker)
- [Plex - Media Server Official website](https://www.plex.tv/)
- [Plex - Claim Token URL](https://www.plex.tv/claim/)