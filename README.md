# README

メモを置くリポジトリです。

## INFO

```
# cat /etc/redhat-release
CentOS Linux release 8.4.2105
```

```
# uname -a
4.18.0-305.19.1.el8_4.x86_64 #1 SMP Wed Sep 15 15:39:39 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
```

```
[root@localhost system-connections]# cat bond0.nmconnection
[connection]
id=bond0
uuid=bc678a7a-d6f0-47fe-b536-c35565f67087
type=bond
interface-name=bond0
timestamp=1758865359

[bond]
downdelay=0
fail_over_mac=0
miimon=100
mode=active-backup
primary=ens192
updelay=0

[ipv4]
address1=192.168.10.231/24
gateway=10.106.254.206
method=manual

[ipv6]
addr-gen-mode=default
method=auto

[proxy]
[root@localhost system-connections]# cat ens192.nmconnection
[connection]
id=ens192
uuid=d438b261-7e7d-4b4d-b090-f3de04075fb1
type=ethernet
controller=bond0
interface-name=ens192
port-type=bond
timestamp=1758866249

[ethernet]
duplex=full
speed=100

[bond-port]
[root@localhost system-connections]# cat ens224.nmconnection
[connection]
id=ens224
uuid=62ed95c2-3858-4d9f-985c-581145d3ff79
type=ethernet
controller=bond0
interface-name=ens224
port-type=bond
timestamp=1758866249

[ethernet]
duplex=full
speed=100

[bond-port]
```
