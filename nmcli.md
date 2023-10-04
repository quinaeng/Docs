```
# nmcli connection add con-name ens224 ifname ens224 type ethernet
# nmcli connection modify ens224 ipv4.method manual ipv4.addresses 172.25.10.1/24 autoconnect yes
```
