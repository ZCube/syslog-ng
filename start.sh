#/bin/sh
chmod 0644 /etc/logrotate.conf
chmod 0644 /etc/syslog-ng/syslog-ng.conf
supervisord --nodaemon --configuration /etc/supervisord.conf