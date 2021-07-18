# AZPLex - your PLex Media Server in the cloud

## Introduction
AZPlex is an **experiment** to implement Plex Media server (using the [official container image from Plex Inc](https://github.com/plexinc/pms-docker)) deployed in a Azure PaaS service (ACI or WebApp) and three different Azure fileshares on a standard storage account.

At the moment, you are able to access the Plex Media Server interface and congiure your server, but you are not able to stream.

## Current Azure Limitations

- Using ACI, The volume mounts are exposed to the container via **SMB** from Azure File Shares **Standard**. While this is fine for media, it is unacceptable for the `/config` directory because SMB does not support file locking. This **will** corrupt your database which can lead to slow behavior and crashes: to avoid this you should put the `/config` directory mount inside the container and not on Storage account making all the `/config` directory ephimeral or in a **NFS File Share** (see next point). Same story for the SQLite databases.
- You can create an Azure File Share in NFS(4.1 - in preview) but only in the **Premium** tier, only using a private VNET (private endpoint - which makes sense). Without considering the increased costs, the problem is that ACI doesn't support them and also ACI cannot be accessed from outside if connected to private network without using an Azure App Gateway that comes with additional costs and additional issues (you cannot set the IP address of the ACI container and this means you should probably update AppGW confinge at every restart/redeploy)

## How to generate the Plex Claim Token

If the claim token is not added during initial configuration you will need to use ssh tunneling to gain access and setup the server for first run. During first run you setup the server to make it available and configurable. However, this setup option will only be triggered if you access it over http://localhost:32400/web, it will not be triggered if you access it over http://ip_of_server:32400/web.

for this reason is important to provide the toker at creation time.

## How much does it cost to run AZPlex?

## References

- [GitHub - Official Docker container for Plex Media Server](https://github.com/plexinc/pms-docker)
- [Plex - Media Server Official website](https://www.plex.tv/)
- [Plex - Claim Token URL](https://www.plex.tv/claim/)