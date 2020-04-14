Shinken
=============

## Requirements
- [X] Docker engine configured with linux containers
- [X] The `docker-compose` cli (should be shipped with docker)
- [X] >256Mb of RAM (for dockers containers)


## Installation (Clone and launch the docker stack)
```bash
# First you need to clone (or download) the repository
git clone git@github.com:IAmFrench/EFREI-M1-SNMP.git
```
![Git Clone](./artefacts/git_clone.gif)

```bash
# Then set your working directory inside the downloaded repository
cd EFREI-M1-SNMP
```
![cd efrei](./artefacts/cd_efrei.gif)


```bash
# And finally launch the stack
# Since you don't have on your local registry the required images, docker-compose will build them for you
# PS: The initial build will take some times
docker-compose up -d
```
![docker-compose up](./artefacts/docker-compose_up.gif)
![docker-compose up ready](./artefacts/docker-compose_up_ready.png)

Tips: You can check your the status of your stack by using the `docker-compose ps` command
```bash
docker-compose ps
```
![docker-compose ps](./artefacts/docker-compose_ps.png)

or using the Docker Desktop Dashboard:
![Docker dashboard](./artefacts/docker_desktop_dashboard.png)

> Tips: You can listen all logs by clicking on the project stack

![Docker dashboard stack details](./artefacts/docker_desktop_stack_infos.png)

## Access
You can open the Shinken GUI at http://localhost:80
> Username: admin    
> Password: admin

![shinken webGUI login page](./artefacts/shinken_webGUI_login_page.png)


Then you can view our host in the [`host menu`](http://localhost:80/all?search=type:host%20is:up%20isnot:ack%20isnot:downtime)
![shinken webGUI hosts page](./artefacts/shinken_webGUI_hosts.png)

Open a host and check infos about it.
You can see various informations collected by the snmp agent

![shinken webGUI client1](./artefacts/shinken_webGUI_client1.png)
> Note: The TimeSync isn't available because it check a NTP agent, we only unse SNMP for this lab.


Let's open the [`Disks`](http://localhost:80/service/client1/Disks) metric from our [`client1`](http://localhost:80/host/client1) host:
![shinken webGUI client1 Disks link](./artefacts/shinken_webGUI_client1_Disks_link.png)

Here is the [`Disks`](http://localhost:80/service/client1/Disks) page:
![shinken webGUI client1 Disks page](./artefacts/shinken_webGUI_client1_Disks_page.png)


## Configuration
If you want you can add or remote host to shinken, to do so, just edit the [`./shinken/config/clients.cfg`](./shinken/config/clients.cfg) file

## Clean-up
```bash
# To stop and remove the stack just use the docker-compose down command with -v as an argument
docker-compose down -v
```
