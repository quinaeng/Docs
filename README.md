```
cat /etc/logrotate.d/rsyslog
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





いつもの手順を実施

・バックアップ
cp /etc/pam.d/system-auth /etc/pam.d/system-auth.bak
cp /etc/pam.d/password-auth /etc/pam.d/password-auth.bak

・設定
sed -i 's/pam_pwquality.so.*/pam_pwquality.so try_first_pass local_users_only retry=3 authtok_type=/' /etc/pam.d/system-auth
sed -i 's/pam_pwquality.so.*/pam_pwquality.so try_first_pass local_users_only retry=3 authtok_type=/' /etc/pam.d/password-auth

grep pwquality /etc/pam.d/system-auth /etc/pam.d/password-auth

vi /etc/pam.d/passwd
password include system-auth    ← 追加

```
