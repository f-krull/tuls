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
  * Go to `http://<HOST>:<PORT>` (default: http://localhost:8080)  
    
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
  * Any services should 
    * run in foreground
    * write any log info stdout or stderr
    * exit with 0 on success
    * exit with != 0 on error

### Webserver (lighttpd)

#### change port
  * Change the port (default 8080) defined in the `EXECSTART` entry of the webserver `.service` file (default `services/webserver.service`)

#### custom html and cgi files 
  * By default `./var/www` is a symlink to `example/www`. 
    Replace `./var/www` with a symlink to your custom folder.
  
### Gitea
  * Replace the symlink `opt/gitea/custom` to a directory containing your customized files.
  * Edit `opt/gitea/custom/conf/app.ini` to change gitea settings.

### Backup (rsnapshot)
  * edit `user.conf` and set `snapshot_root `and `backup` entries
  * make sure the directory `snapshot_root` already exists and is writable (mkdir ... if not)

## Folder structure
  * `./bin/` TULS bins
  * `./etc/` TULS config files
  * `./opt/` Optional apps; pre-packaged services
  * `./run/` Run-time variable data; invalid after each reboot
  * `./var/` Variable files; files that will change over time
  * `./var/exit/` Exit codes of services 
  * `./var/log/` Log files of services
  * `./var/www` Symlink to www folder hosted by webserver

## Requirements
  * bash
  * build tools (make, gcc, ...)
  * gettext (provides envsubst used opt/gitea/Makefile; could be bypassed)
  * rsync (backup)
  * zlib (git, lighttpd)

### prepare_offline
  * make
  * wget

## TODO
  * rnsapshot example service and webui?
  * busybox: use INSTALL_NO_USR config

## Test / Docker

Place the source of tuls into `/tmp/tuls`.

```
docker run --rm -ti -p 8080:8080 -p 3000:3000 -v /tmp/:/tuls_src ubuntu:14.04 bash -c '
cd /tmp
cp -rp /tuls_src/tuls .
cd tuls
apt-get update && apt-get install -y wget build-essential zlib1g-dev gettext-base rsync
make example -j 5
# some workarouds to make it run in docker / as root
export USER=$(whoami)
bin/update
# cron 
nohub var/cron/webserver &
nohub var/cron/gitea & 
bash
'
```
