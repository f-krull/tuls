# TSD userland services

## Goals 
  * starting services (currently a wrapper for crontab - use systemd in the future?)
    * make sure no service runs more than once
    * version control of service configuration
    * write logs
  * include basic services (services that are likely to be relevant for any TSD project)
    * webserver
      * basic entry page 
      * monitoring of service status and logs
      * easy install of simple webapps (cgi)
    * gitea
    * rsnapshot + webui

## Quick start

### outside TSD (with internet connection) 
  * Clone the repository and change into directory  
    `git clone ... && cd ...`
  * Download all files needed to build the services.  
    `make prepare_offline`
  * copy the whole directory into TSD

### inside TSD
  * `cd tuls...`
  * Build software and set up example services  
    `make example`  
  * Edit configs (ports, etc.). See below for specific details
  * Auto-start services (default: webserver, gitea, status monitoring)  
    `bin/update`
  * Go to `http://[HOST]:[PORT]` (default: http://localhost:8080)  
    
#### uninstall
  * Disable auto-start  
    `bin/disable`
  * Stop services  
    `bin/stop`

## Configuration

### Services
  * tbd.
### Webserver (lighttpd)
  * tbd.
### Gitea
  * tbd.
### Backup (rsnapshot)
  * tbd.


## Requirements
  * bash
  * build tools (make, gcc, ...)
  * git? (gitea)
  * rsync (backup)

### prepare_offline
  * make
  * wget

## TODO
  * entry page beautification
  * rnsapshot example service and webui?
  * busybox: use INSTALL_NO_USR config
