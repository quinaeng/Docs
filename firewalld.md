# firewalld

## SNAT(1対1)の設定

・IPマスカレードが有効かどうか確認する。
```
# firewall-cmd --direct --add-rule ipv4 nat POSTROUTING 0 -s 192.168.10.110 -j SNAT --to-source 192.168.0.100
```

## SNAT(多対1)の設定

・IPマスカレードが有効かどうか確認する。
```
# firewall-cmd --zone=external –query-masquerade
```

・IPマスカレードを有効化
```
# firewall-cmd --zone=external –add-masquerade
```

・インターフェースをexternal zoneに属する
```
# firewall-cmd --change-interface=enp0s3 --zone=external
```

・ポリシーを作成
```
# firewall-cmd --permanent --new-policy dnat-policy
# firewall-cmd --permanent --policy=dnat-policy --add-ingress-zone=HOST
# firewall-cmd --permanent –policy=dnat-policy –add-egress-zone=ANY
```

・リロード
```
# firewall-cmd --reload
```

## DNATの設定

・ルーティングを有効化
```
# echo "net.ipv4.conf.all.route_localnet=1" > /etc/sysctl.d/90-enable-route-localnet.conf
# sysctl -p /etc/sysctl.d/90-enable-route-localnet.conf
```

・ 192.168.0.1:443宛の通信を192.168.10.100:443に転送する
```
# firewall-cmd --permanent --policy=DNAT-Policy --add-rich-rule='rule family="ipv4" destination address="192.168.0.1" forward-port port="443" protocol="tcp" to-port="443" to-addr="192.168.10.100"'
```
