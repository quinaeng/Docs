## iptablesの処理順番(Chain)

(1)PREROUTING
ルーティング前のパケットに対して適用されるチェーンです。
パケットがルーターに到着すると、ルーティングテーブルを参照して、どのように処理するかを決定します。
その後、PREROUTINGチェーンが適用されます。このチェーンでパケットを変換することができます。
SNATを設定する場合、受信側のインターフェースで設定する必要がある。

(2)INPUT
パケットが宛先としてこのシステムに送信された場合に適用されるチェーンです。
通常、INPUTチェーンでファイアウォールルールを適用して、パケットの受信を許可または拒否します。

(3)FORWARD
パケットがこのシステムを通過して、別の宛先に転送される場合に適用されるチェーンです。
通常、FORWARDチェーンでパケットの転送を許可または拒否します。

(4)OUTPUT
パケットがこのシステムから出力される場合に適用されるチェーンです。
通常、OUTPUTチェーンでパケットの送信を許可または拒否します。

(5)POSTROUTING
ルーティング後のパケットに対して適用されるチェーンです。
送信先IPアドレスの変換、NAT、マスカレードなど、出力パケットの変換を行うために使用されます。
DNATを設定する場合、送信するインターフェースで設定する必要がある。

---

## Tableの種類

・FILTER
パケットのフィルタリングを行うチェーン。パケットの許可や拒否を行うためのルールを設定します。

・NAT
ネットワークアドレス変換を行うチェーン。IPアドレスやポート番号の変換を行います。

・MANGLE
パケットのフラグメント、TOS、TTL、MARKなどの特殊な処理を行うチェーン。

・RAW
コネクショントラッキングの前に適用され、TCPやUDPのような特定のプロトコルに対してRAWモードで処理を行うチェーン。

・SECURITY
SELinuxによるパケットのセキュリティポリシーを設定するチェーン。


## TableとChainの関係

| FILTER TABLE | NAT TABLE | MANGLE TABLE |
| --- | --- | ---|
| INPUT CHAIN | OUTPUT CHAIN | INPUT CHAIN |
| OUTPUT CHAIN | PREROUTING CHAIN | OUTPUT CHAIN |
| FORWARD CHAIN | POSTROUTING CHAIN | FORWARD CHAIN |
|   |   | PREROUTING CHAIN |
|   |   | POSTROUTING CHAIN |


---

## 処理ルール

ACCEPT: ルールに一致するパケットを受け入れます。
DROP: ルールに一致するパケットを破棄します。
REJECT: ルールに一致するパケットを破棄し、送信元にエラーメッセージを返します。
SNAT: 送信元アドレスを変更します。
DNAT: 送信先アドレスを変更します。
MASQUERADE: プライベートIPアドレスを公開IPアドレスに変換します。
LOG: パケットをログに記録します。

---

## iptablesコマンドのオプション

```
-A (--append): チェーンの最後にルールを追加します。
-D (--delete): チェーンからルールを削除します。
-I (--insert): チェーンの先頭にルールを追加します。
-R (--replace): チェーン内の既存のルールを置き換えます。
-L (--list): ルールを表示します。
-F (--flush): チェーン内のすべてのルールを削除します。
-N (--new-chain): 新しいチェーンを作成します。
-P (--policy): チェーンのデフォルトポリシーを設定します。
-s (--source): 送信元IPアドレスを指定します。
-d (--destination): 宛先IPアドレスを指定します。
-p (--protocol): プロトコルを指定します。
-j (--jump): ルールに一致した場合に実行するアクションを指定します。
-m (--match): ルールに一致するための条件を指定します。
-i (--in-interface): パケットの入力インターフェイスを指定します。
-o (--out-interface): パケットの出力インターフェイスを指定します。
```

---

## 設定例

・iptablesのインストール
```
# dnf install -y iptables-services
```

・設定ファイルのバックアップ
```
# cp /etc/sysconfig/iptables /etc/sysconfig/iptables_`date "+%Y%m%d-1"`
```

・設定ファイルの編集
```
# vi /etc/sysconfig/iptables
```

```
#情報
#ens160:192.168.10.201
#ens224:10.10.10.1

*filter

# 暗黙のDeny設定
:INPUT DROP [0:0]
:FORWARD DROP [0:0]
:OUTPUT ACCEPT

# SSH接続の許可
-A INPUT -p tcp -m state --state NEW -m tcp --dport 22 -j ACCEPT

# ICMPの許可
-A INPUT -p icmp --icmp-type any -j ACCEPT

# 送信元のセグメントからの通信を許可する
-A INPUT -s 192.168.10.0/24 -j ACCEPT
-A INPUT -s 10.10.10.0/24 -j ACCEPT

# 宛先のセグメントへの通信を許可する
# (折り返し通信を許可するためにFORWARDでセグメントを許可する)
-A FORWARD -d 192.168.10.0/24 -j ACCEPT
-A FORWARD -d 10.10.10.0/24 -j ACCEPT

COMMIT

*nat

# 暗黙のDeny
:PREROUTING DROP [0:0]
:POSTROUTING DROP [0:0]
:OUTPUT ACCEPT

# ポート指定にする
-A PREROUTING -p tcp -m tcp --dport 80 -j DNAT --to-destination 10.10.10.2:80

# ens224 output方向のインターフェースに設定する必要がある。
-A POSTROUTING -s 192.168.10.202/24 -o ens224 -j SNAT --to-source 10.10.10.1

COMMIT

# *mangle
# -A OUTPUT -p tcp --dport 80 --tos 0x08 -j MARK --set-mark 1
# COMMIT
```


・サービスの再起動
```
# systemctl restart iptables
```

