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

  * By default `./services` is a symlink to `example/services`. 
    Replace `./services` with a symlink to your custom folder 
    containg your own `*.service` files.
  * Run `bin/update` after configuring services.
  * Any services should run in foreground and write log stdout or stderr

### Webserver (lighttpd)

#### change port
  * Change the port (default 8080) defined in the `EXECSTART` entry of the webserver `.service` file (default `services/webserver.service`)

#### custom html and cgi files 
  * By default `./var/www` is a symlink to `example/www`. 
    Replace `./var/www` with a symlink to your custom folder.
  
### Gitea
  * Edit `opt/gitea/custom/conf/app.ini` to change gitea settings.
  * Replace the symlinks `opt/gitea/custom/public` and `opt/gitea/custom/templates` to directories conatining your customized files.

### Backup (rsnapshot)
  * tbd.

## Folder structure
  * `./bin/` TULS bins
  * `./etc/` TULS config files
  * `./opt/` Optional apps; pre-packaged services
  * `./run/` Run-time variable data; invalid after each reboot
  * `./var/` Variable files; files that will change over time
  * `./var/exit/` Exit codes of services 
  * `./var/log/` Log files of services
  * `./var/www` Symlink to wwww folder hosted by webserver

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
