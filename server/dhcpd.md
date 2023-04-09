# DHCPサーバ構築

・パッケージのインストール

```
dnf install -y dhcp-server
```

・dhcpdの起動と自動起動設定

```
systemctl enable --now dhcpd
```

・dhcpd.confのバックアップ

```
cp -ip /etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf.org
```

※「cp -ip /usr/share/doc/dhcp-server/dhcpd.conf.example /etc/dhcp/dhcpd.conf」

・dhcpd.confの編集

```
vi /etc/dhcp/dhcpd.conf
```

```
# A slightly different configuration for an internal subnet.
subnet 192.168.10.0 netmask 255.255.255.0 {
  range 192.168.10.2 192.168.10.100;
  option domain-name-servers 192.168.10.200;
  option routers 192.168.10.254;
}

host reserve {
  hardware ethernet 00:0c:29:d6:e3:ac;
  fixed-address 192.168.10.99;
}

```

・払い出し済みのIPアドレスの確認

```
cat /var/lib/dhcpd/dhcpd.leases
```
