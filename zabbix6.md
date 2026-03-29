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


・モジュールのインストール(Perl)
cpan Config::IniFiles
cpan Net::IP module

vi /etc/snmptt/snmptt.ini
#snmpttをスタンドアローンではなくデーモンモードで起動する
mode = daemon
net_snmp_perl_enable = 1
net_snmp_perl_best_guess = 2

#日付と時間のフォーマット
date_time_format = %Y/%m/%d %H:%M:%S

#ZBXが参照するログファイルの場所
log_file = /var/log/snmptt/snmptt.log

#動作確認のためデバッグモードに設定
# sleep = 1 #処理間隔（秒）
# DEBUGGING = 1 #動作確認終了後は0に変更してください。
# DEBUGGING_FILE = /var/log/snmptt/snmptt.debug
# DEBUGGING_FILE_HANDLER = /var/log/snmptt/snmptthandler.debug



https://www.cybertrust.co.jp/blog/linux-oss/system-monitoring/tech-lounge/zbx-tl-001.html
```

- ブラウザでアクセスする
  - http://<IP>/zabbix
  - user: Admin
  - pass: zabbix

