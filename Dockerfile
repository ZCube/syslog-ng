from alpine:3.5

RUN buildDeps='' runtimeDeps='python py2-pip syslog-ng logrotate' \
  && apk add --update $buildDeps $runtimeDeps \ 
  && pip install --upgrade pip \
  && pip install supervisor \
  && apk del $buildDeps 
  
EXPOSE 514 514/udp


RUN touch crontab.tmp \
    && echo '1 0 * * * /usr/sbin/logrotate /etc/logrotate.conf' > crontab.tmp \
    && crontab crontab.tmp \
    && rm -rf crontab.tmp
    
ADD logrotate.conf /etc/logrotate.conf
ADD syslog-ng.conf /etc/syslog-ng/syslog-ng.conf
ADD supervisord.conf /etc/supervisord.conf
ADD start.sh /start.sh

RUN chmod 0755 start.sh

VOLUME [ "/var/log" ]

CMD ["/bin/sh", "/start.sh"]