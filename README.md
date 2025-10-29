[sds@smzlog01 ~]$
[sds@smzlog01 ~]$
[sds@smzlog01 ~]$ cat /etc/logrotate.d/rsyslog
/var/log/cron
/var/log/maillog
/var/log/messages
/var/log/secure
/var/log/spooler
{
    missingok
    sharedscripts
    postrotate
        /usr/bin/systemctl -s HUP kill rsyslog.service >/dev/null 2>&1 || true
    endscript
}
[sds@smzlog01 ~]$
[sds@smzlog01 ~]$
[sds@smzlog01 ~]$
[sds@smzlog01 ~]$
