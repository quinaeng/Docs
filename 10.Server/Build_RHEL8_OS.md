# Linuxサーバ構築(RedHat Linux Enterprise 8.x)
---
<br>
- サービス自動起動の設定<br>
dnf install -y rsyslog net-snmp sos bind-utils<br>
<br>
- サービス自動起動の設定<br>
systemctl start rsyslog && systemctl enable rsyslog<br>
systemctl start snmpd && systemctl enable snmpd<br>
<br>
- sshログイン用ユーザ作成<br>
useradd sshuser -p password<br> 
<br>
- Tunedの設定(仮想サーバ)<br> 
tuned-adm profile virtual-guest balanced<br>
<br>
- Tunedの設定(物理サーバ)<br>
tuned-adm profile balanced<br>
<br>
- マルチユーザモード(CUI)でOSを起動<br>
systemctl set-default multi-user.target<br>
<br>
- ホスト名の設定<br>
hostnamectl set-hostname sv01<br> 
<br>
- ネットワークの設定<br>
nmcli connection modify <ifname> ipv4.addresses <ip/sm> \<br>
ipv4.dns <DNS#1>,<DNS#2> \<br>
ipv4.gateway <ip> \<br>
ipv6.method disabled \<br>
connection.autoconnect yes<br>
<br>
- 「ctrl + alt + delete」のリブート防止設定<br>
systemctl mask ctrl-alt-del.target<br>
<br>
- sshの設定<br> 
cp -ip /etc/ssh/sshd_config /etc/ssh/sshd_config.org<br>
vi /etc/ssh/sshd_config<br>

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
<br>
- SELINUXの無効化<br>
cp -ip /etc/selinux/config /etc/selinux/config.org<br>
vi /etc/selinux/config<br>

```
SELINUX=disabled
```
<br>
- suコマンドをwheelグループに所属しているユーザのみに利用制限(suコマンドの禁止)<br>
cp -ip /etc/pam.d/su /etc/pam.d/su.org <br>
vi /etc/pam.d/su<br>
 
```<br>
auth            required        pam_wheel.so use_uid
```
<br>
- カーネルパラメータの設定<br>
cp -ip /etc/sysctl.conf /etc/sysctl.conf.org<br>
vi /etc/sysctl.conf<br>

```<br>
#TCP制御<br>
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
<br>
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
<br>
- カーネルパラメータの設定反映<br>
sysctl -p<br>
<br>
- IPv6無効化(コメントアウト)<br>

```
#udp6       tpi_clts      v     inet6    udp     -       -
#tcp6       tpi_cots_ord  v     inet6    tcp     -       -
```
- vi /etc/hosts<br>

```
#::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
```
cp -ip /etc/default/grub /etc/default/grub.org<br>
vi /etc/default/grub<br>

```
GRUB_CMDLINE_LINUX="ipv6.disable=1"
```
※デフォルトの設定に「ipv6.disable=1」を追加する<br>
<br>
- ホスト名での通信を無効化<br>
vi /etc/nsswitch.conf<br>

```
#hosts:      files dns myhostname
hosts:      files dns
```
<br>
- Journalの設定<br>
cp -ip /etc/systemd/journald.conf /etc/systemd/journald.conf.org<br>
vi /etc/systemd/journald.conf<br>

```
Compress=yes
RateLimitInterval=0s
```
<br>
- Firewalldの設定<br>
- デフォルト設定の削除<br> 
firewall-cmd --new-zone Secured_Zone --permanent<br>
firewall-cmd --zone=Secured_Zone --add-port=222/tcp --permanent<br>
firewall-cmd --reload<br>
nmcli connection modify <ifname> connection.zone Secured_Zone<br>
<br>
- 設定の確認<br> 
firewall-cmd --list-all --zone=Secured_Zone<br>
<br>
- 不要サービスの停止<br>
systemctl disable kdump<br> 
<br>
- OS再起動<br> 
reboot<br>
 

