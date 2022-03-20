#  Build_RHEL8_OS

- OSのアップデート

```
dnf update -y
```

- タイムゾーンの設定

```
sudo timedatectl set-timezone Asia/Tokyo
```

- サービス自動起動の設定

```
dnf install -y rsyslog net-snmp sos bind-utils
```

- サービス自動起動の設定

```
systemctl enable --now rsyslog
systemctl enable --now snmpd
```

- sshログイン用ユーザ作成

```
useradd sshuser -p password
```


- 管理者用ユーザ作成

```
useradd admin -p password -G wheel
```

- Tunedの設定(仮想サーバ) 

```
tuned-adm profile virtual-guest balanced
```

- Tunedの設定(物理サーバ)

```
tuned-adm profile balanced
```

- マルチユーザモード(CUI)でOSを起動

```
set-default multi-user.target
```

- ホスト名の設定

```
hostnamectl set-hostname sv01
```

- ネットワークの設定

```
nmcli connection modify <ifname> ipv4.addresses <ip/sm> \
ipv4.dns DNS#1,DNS#2 \
ipv4.gateway gateway \
ipv6.method disabled \
connection.autoconnect yes
```

- 「ctrl + alt + delete」のリブート防止設定

```
systemctl mask ctrl-alt-del.target
```

- sshの設定

```
cp -ip /etc/ssh/sshd_config /etc/ssh/sshd_config.org
vi /etc/ssh/sshd_config
```

```
Port 222
AddressFamily inet
ListenAddress <server's ip>
AllowUsers  sshuser@<ip>
LogLevel INFO
PermitRootLogin no
MaxAuthTries 5
MaxSessions 2
PermitEmptyPasswords no
Protocol 2
UseDNS no
```

- SELINUXの無効化

```
cp -ip /etc/selinux/config /etc/selinux/config.org
vi /etc/selinux/config
```

```
SELINUX=disabled
```

- suコマンドをwheelグループに所属しているユーザのみに利用制限(suコマンドの禁止)

```
cp -ip /etc/pam.d/su /etc/pam.d/su.org 
vi /etc/pam.d/su
```

```
auth            required        pam_wheel.so use_uid
```

- sudoコマンドをwheelグループに所属しているユーザのミニ利用制限(sudoコマンドの禁止)

```
visudo
```

```
%wheel  ALL=(ALL)       ALL
```

- カーネルパラメータの設定

```
cp -ip /etc/sysctl.conf /etc/sysctl.conf.org
vi /etc/sysctl.conf
```

```
#TCP制御
net.core.rmem_default = 253952
net.core.wmem_default = 253952
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.ipv4.tcp_rmem = 253952 253952 16777216
net.ipv4.tcp_wmem = 253952 253952 16777216
net.ipv4.tcp_window_scaling = 1

#DDos攻撃対策
net.ipv4.tcp_fin_timeout = 30

#Syn Flood攻撃対策
net.ipv4.tcp_syncookies = 1

#IPv6無効化
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1

#ルーティングの無効化
net.ipv4.conf.all.forwarding = 0
net.ipv6.conf.all.forwarding = 0

#Ping(ICMP)を返さない設定
net.ipv4.icmp_echo_ignore_all = 1

#IP Redirectを受け付けない設定
net.ipv4.conf.all.accept_redirects = 0
net.ipv6.conf.all.accept_redirects = 0
net.ipv4.conf.all.secure_redirects = 0
```

- カーネルパラメータの設定反映

```
sysctl -p
```

- IPv6無効化(コメントアウト)

```
cp -ip /etc/netconfig /etc/netconfig.org
vi /etc/netconfig
```

```
#udp6       tpi_clts      v     inet6    udp     -       -
#tcp6       tpi_cots_ord  v     inet6    tcp     -       -
```

```
vi /etc/hosts
```

```
#::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
```

```
cp -ip /etc/default/grub /etc/default/grub.org
vi /etc/default/grub
```

```
GRUB_CMDLINE_LINUX="ipv6.disable=1"
```

※デフォルトの設定に「ipv6.disable=1」を追加する

- ログイン失敗を5回繰り返すと15分間アカウントをロックする

```
vi /etc/pam.d/password-auth
```

```
auth        required      pam_faillock.so preauth silent audit deny=5 unlock_time=600
```

- ホスト名での通信を無効化

```
vi /etc/nsswitch.conf
```

```
#hosts:      files dns myhostname
hosts:      files dns
```

- Journalの設定

```
cp -ip /etc/systemd/journald.conf /etc/systemd/journald.conf.org
vi /etc/systemd/journald.conf
```

```
Compress=yes
RateLimitInterval=0s
```

## Firewalldの設定


- デフォルト設定の削除

```
firewall-cmd --new-zone Secured_Zone --permanent
firewall-cmd --zone=Secured_Zone --add-port=222/tcp --permanent
firewall-cmd --reload
nmcli connection modify ifname connection.zone Secured_Zone
```

- 設定の確認

```
firewall-cmd --list-all --zone=Secured_Zone
```

- 不要サービスの停止

```
systemctl disable kdump
```

- OS再起動

```
reboot
```
