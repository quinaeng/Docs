# Zabbix6構築手順

```
# rpm -Uvh https://repo.zabbix.com/zabbix/6.0/rhel/9/x86_64/zabbix-release-latest-6.0.el9.noarch.rpm
# dnf clean all

dnf install zabbix-server-mysql zabbix-web-mysql zabbix-apache-conf zabbix-sql-scripts zabbix-selinux-policy zabbix-agent

# mysql -uroot -p
password
mysql> create database zabbix character set utf8mb4 collate utf8mb4_bin;
mysql> create user zabbix@localhost identified by 'password';
mysql> grant all privileges on zabbix.* to zabbix@localhost;
mysql> set global log_bin_trust_function_creators = 1;
mysql> quit;

# zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -p zabbix

# mysql -uroot -p
password
mysql> set global log_bin_trust_function_creators = 0;
mysql> quit;


vi /etc/zabbix/zabbix_server.conf
DBPassword=password

# systemctl restart zabbix-server zabbix-agent httpd php-fpm
# systemctl enable zabbix-server zabbix-agent httpd php-fpm

```


- 以下は作成中
```
dnf install -y epel-release
dnf install -y net-snmp net-snmp-utils

・以下から最新のsnmpttを取得する(tar.gz)
https://github.com/snmptt/snmptt/releases

# 参考URL
https://snmptt.org/docs/snmptt.shtml#Installation

https://github.com/snmptt/snmptt/releases
wget <url>
```

- ブラウザでアクセスする
  - http://<IP>/zabbix
  - user: Admin
  - pass: zabbix

