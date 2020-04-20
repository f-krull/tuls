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

## TODO
  * buybox: use INSTALL_NO_USR config
  * gitea: use customized pages

## Notes

  * web server
  * rsnapshot
  * service mgr
    * start servics
    * write cron tab
    * show status / logs
  * gitea server
  * use busybox