# AZPLex - Your Plex Media Server in Azure

## Introduction
AZPlex is an **experiment** to implement Plex Media server (using the [official container image from Plex Inc](https://github.com/plexinc/pms-docker)) deployed in a Azure PaaS service (ACI or WebApp) and three different Azure File Shares on a Standard V2 Storage Account.

At the moment, you are able to access the Plex Media Server interface and congiure your server, but you are not able to stream.

## Current Architecture

![AZPLex Current Architecture](https://github.com/francesco-sodano/azplex/blob/main/images/AZPlexArchitecture.JPG?raw=true)

## Current Azure Limitations

### Using Azure Contianer Instances

- Using ACI, The volume mounts are exposed to the container via **SMB** from Azure File Shares **Standard**. While this is fine for media, it is unacceptable for the `/config` directory because SMB does not support file locking. This **will** corrupt your database which can lead to slow behavior and crashes: to avoid this you should put the `/config` directory mount inside the container and not on Storage account making all the `/config` directory ephimeral or in a **NFS File Share** (see next point). Same story for the SQLite databases.
- You can create an [Azure File Share in NFS (4.1 - in preview)](https://docs.microsoft.com/en-us/azure/storage/files/storage-files-how-to-create-nfs-shares?tabs=azure-portal) but only in the **Premium** tier, only using a private VNET (private endpoint - which makes sense). Without considering the increased costs, the problem is that ACI doesn't support them and also ACI cannot be accessed from outside if connected to private network without using an Azure App Gateway that comes with additional costs and additional issues (you cannot set the IP address of the ACI container and this means you should probably update AppGW confinge at every restart/redeploy).

### Using Azure WebApp for Containers

- Same issue as ACI for the SMB mounts
- External access will be always on port 80/443
- Using the official contianer image, you are not able to configure your plex media server (no SSH connection available to access `localhost`) 

## How to generate the Plex Claim Token

If the claim token is not added during initial configuration you will need to use ssh tunneling to gain access and setup the server for first run. During first run you setup the server to make it available and configurable. However, this setup option will only be triggered if you access it over http://localhost:32400/web, it will not be triggered if you access it over http://ip_of_server:32400/web.

for this reason is important to provide the toker at creation time.

## How much does it cost to run AZPlex?

## References

- [GitHub - Official Docker container for Plex Media Server](https://github.com/plexinc/pms-docker)
- [Plex - Media Server Official website](https://www.plex.tv/)
- [Plex - Claim Token URL](https://www.plex.tv/claim/)
- [Azure - How to create an NFS share (preview)](https://docs.microsoft.com/en-us/azure/storage/files/storage-files-how-to-create-nfs-shares?tabs=azure-portal)
- [Azure - Mount an Azure file share in Azure Container Instances](https://docs.microsoft.com/en-us/azure/container-instances/container-instances-volume-azure-files)