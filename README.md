# AZPLex - your PLex Media Server in the cloud

## Introduction
AZPlex is an implementation of Plex Media server (using the official container image from Plex Inc) deployed in a Azure Container Instance and three different Azure fileshares on two different storage accounts.

## Enable NFSv3

```bash
az feature register --namespace Microsoft.Storage --name AllowNfsFileShares
az provider register -n Microsoft.Storage
```

## How to generate the Plex Claim Token

## How much does it cost to run AZPlex?

## References

- [GitHub - Official Docker container for Plex Media Server](https://github.com/plexinc/pms-docker)
- [Plex - Media Server Official website](https://www.plex.tv/)
- [Plex - Claim Token URL](https://www.plex.tv/claim/)