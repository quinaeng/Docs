# DNSサーバ構築手順

・パッケージのインストール

```
# dnf install -y bind bind-chroot bind-utils
```

・named-chrootの起動と自動起動設定

```
# systemctl enable --now named-chroot
```

・namedが停止していて自動起動設定がdisableになっていることを確認

```
# systemctl status named
# systemctl is-enabled named
```

・named-chrootが起動していて自動起動設定がenableになっていることを確認

```
# systemctl status named-chroot
# systemctl is-enabled named-chroot
```

・chroot化の設定

```
# /usr/libexec/setup-named-chroot.sh /var/named/chroot on
```

`# vi /etc/sysconfig/named`

```
ROOTDIR=/var/named/chroot
```


・正引きのゾーンファイルの作成
ゾーンファイルは、上記をコピーペースをしてもなぜか書式が間違っていてnamed-chrootを起動できないことがあるため、「/var/named/named.localhost」をコピーしてそれを編集することで正確にゾーンファイルを作成することができる
`# vi /var/named/example.local`

```
$TTL 1D
@       IN SOA  @ ns.example.local. (
                                        0       ; serial
                                        1D      ; refresh
                                        1H      ; retry
                                        1W      ; expire
                                        3H )    ; minimum
                    IN      NS      ns.example.local.
example.local.      IN      A       192.168.10.107
ns                  IN      A       192.168.10.107
web                 IN      CNAME   test.local.
```


・逆引きのゾーンファイルの作成
ゾーンファイルは、上記をコピーペースをしてもなぜか書式が間違っていてnamed-chrootを起動できないことがあるため、「/var/named/named.loopback」をコピーしてそれを編集することで正確にゾーンファイルを作成することができる

`# vi /var/named/rev-example.local`

```
$TTL 1D
@       IN SOA  @ ns.example.local. (
                                        0       ; serial
                                        1D      ; refresh
                                        1H      ; retry
                                        1W      ; expire
                                        3H )    ; minimum
        NS      @
        A       192.168.10.107
107     PTR     example.local.
107     PTR     ns
```

・named.confのバックアップ

```
# cp -ip /etc/named.conf /etc/named.conf.org
```

・named.confの編集

`# vi /etc/named.conf`

```
//
// named.conf
//
// Provided by Red Hat bind package to configure the ISC BIND named(8) DNS
// server as a caching only nameserver (as a localhost DNS resolver only).
//
// See /usr/share/doc/bind*/sample/ for example named configuration files.
//

options {
        listen-on port 53 { 192.168.10.107; };
        listen-on-v6 port 53 { ::1; };
        directory       "/var/named";
        dump-file       "/var/named/data/cache_dump.db";
        statistics-file "/var/named/data/named_stats.txt";
        memstatistics-file "/var/named/data/named_mem_stats.txt";
        secroots-file   "/var/named/data/named.secroots";
        recursing-file  "/var/named/data/named.recursing";
        allow-query     { any; };

        /*
         - If you are building an AUTHORITATIVE DNS server, do NOT enable recursion.
         - If you are building a RECURSIVE (caching) DNS server, you need to enable
           recursion.
         - If your recursive DNS server has a public IP address, you MUST enable access
           control to limit queries to your legitimate users. Failing to do so will
           cause your server to become part of large scale DNS amplification
           attacks. Implementing BCP38 within your network would greatly
           reduce such attack surface
        */
        recursion yes;

        dnssec-enable yes;
        dnssec-validation yes;

        managed-keys-directory "/var/named/dynamic";

        pid-file "/run/named/named.pid";
        session-keyfile "/run/named/session.key";

        /* https://fedoraproject.org/wiki/Changes/CryptoPolicy */
        include "/etc/crypto-policies/back-ends/bind.config";
};

zone "example.local" IN {
    type master;
    file "example.local";
    allow-update { none; };
};

zone "10.168.192.in-addr.arpa" IN {
        type master;
        file "rev-example.local";
        allow-update { none; };
};

logging {
        channel default_debug {
                file "data/named.run";
                severity dynamic;
        };
};

zone "." IN {
        type hint;
        file "named.ca";
};

# include "/etc/named.rfc1912.zones";
include "/etc/named.root.key";
```

・サービス再起動と起動確認

```
systemctl restart named-chroot && systemctl status named-chroot
```


## メモ

### 用語

・dnssec

『DNS応答が正しいサーバーから応答されたものであるか検証する仕組み』です。
ドメインを管理している権威DNSサーバーが問合せを受けた際、返す答えに「鍵(DNSKEY)」と「署名(RRSIG)」をつけて、正しい応答であることを主張します。それを受けたキャッシュDNSサーバーが、その「鍵」と「署名」のセットが正しい組み合わせであるかを検証し、応答が正しいものであるかを判断します。もし、攻撃者が嘘の情報を紛れ込ませたとしても「鍵」と「署名」の検証に失敗するため、キャッシュDNSサーバーで不正な応答であると判断し、名前解決に失敗したとユーザーに返答します。

### コマンド

・DNSキャッシュ削除

```
# rndc flush
```

・名前解決確認

```
# nslookup -type=A example.local <dnsサーバ>
# nslookup -type=PTR 192.168.10.107 <dnsサーバ>
```

・named.confの書式チェック

```
# named-checkconf
```

・ゾーンファイルの書式チェック(あまりあてにならない)

```
# named-checkzone example.local /var/named/example.local
```

### その他

shellスクリプトを実行したとき下記のマウント設定が追加される

・chroot化の設定

```
# /usr/libexec/setup-named-chroot.sh /var/named/chroot on
```

```
binfmt_misc on /proc/sys/fs/binfmt_misc type binfmt_misc (rw,relatime)
tracefs on /sys/kernel/debug/tracing type tracefs (rw,relatime,seclabel)
/dev/mapper/rl-root on /var/named/chroot/etc/named type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/mapper/rl-root on /var/named/chroot/usr/lib64/bind type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
proc on /var/named/chroot/proc/sys/net/ipv4/ip_local_port_range type proc (rw,nosuid,nodev,noexec,relatime)
proc on /proc/sys/net/ipv4/ip_local_port_range type proc (rw,nosuid,nodev,noexec,relatime)
```
