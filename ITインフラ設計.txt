# ITインフラ設計

## Linux共通設定

- ホスト名
- ネットワーク(Bondding,IP,Gateway,DNS)
- タイムゾーン
```
timedatectl
timedatectl list-timezones
timedatectl set-timezone Asia/Tokyo
```
- ログ
- バックアップ(データ、システム)
- サービス自動起動設定

## ディスクパーティション

- Red Hat Linux9のディスクパーティション設計根拠
https://docs.redhat.com/ja/documentation/red_hat_enterprise_linux/9/html/performing_a_standard_rhel_9_installation/recommended-partitioning-scheme_partitioning-reference

- ファイルシステム

| ファイルシステム | 特徴・説明 | 拡大 | 縮小 |
|------------------|------------|------|------|
| ext4             | 現在主流の汎用ファイルシステム。ジャーナリング対応で高性能・安定性あり。多くのディストリビューションで標準採用。 | 可能（オンライン可） | 可能（オフラインのみ） |
| xfs              | 大容量・高パフォーマンス向け。Red Hat系で標準。スナップショット非対応。 | 可能（オンライン可） | 不可 |
| btrfs            | スナップショット、圧縮、自己修復などの高度な機能を持つ。安定性にやや注意が必要。 | 可能（オンライン可） | 可能（オンライン可） |
| ext3             | ext2にジャーナリングを追加した旧世代FS。現在はext4に置き換えられている。 | 可能（オンライン可） | 可能（オフラインのみ） |
| ext2             | 非ジャーナリング。シンプルで軽量。組み込み用途などに利用される。 | 可能（オフライン） | 可能（オフライン） |
| zfs              | 高信頼性・高機能ファイルシステム。スナップショット、圧縮、RAIDなどに対応。Linuxでは追加モジュールが必要。 | 可能（オンライン） | 可能（条件付き） |
| vfat (FAT32)     | Windowsとの互換性を持つ。USBメディアなどに使用。パーミッションやジャーナリング機能なし。 | 可能（ツール利用） | 可能（ツール利用） |
| exfat            | FAT32の後継。大容量ファイルに対応。Windows・macOSと互換性あり。Linuxではドライバが必要。 | 可能（ツール利用） | 不可 |
| ntfs             | Windows標準のファイルシステム。Linuxではntfs-3gで読み書き対応。 | 可能（ntfsresize使用） | 可能（ntfsresize使用、条件あり） |
| iso9660          | CD/DVDなどの光学メディア向け。読み取り専用のファイルシステム。 | 不可 | 不可 |
| tmpfs            | メモリ上の一時ファイルシステム。RAMディスクの一種。高速アクセス用。 | 可能（マウント時に変更） | 可能（マウント時に変更） |
| nfs              | ネットワークファイルシステム。サーバ側の設定による共有。クライアント側ではサイズ制御不可。 | サーバ依存 | サーバ依存 |
| overlayfs        | コンテナ環境で利用される差分ファイルシステム。実体は他のFSに依存。 | 基盤FSに依存 | 基盤FSに依存 |



## ファイルサーバ(Samba)

- 共有名
- 認証の有無
- 拡張性(共有ディレクトリはLVM)
- ゴミ箱機能
- シャドウコピー

- smb.conf
https://www.samba.gr.jp/project/translation/current/htmldocs/manpages/smb.conf.5.html

- コマンドライン
https://www.samba.gr.jp/project/translation/current/htmldocs/manpages/




＃＃ 時刻同期(Chronyd)

- chrony.conf
https://chrony-project.org/doc/4.0/chrony.conf.html?utm_source=chatgpt.com

- タイムゾーン
   - 地球上のある地域で使われている標準時刻（ローカルタイム）のこと。日本はJST(UTC + 9:00)で表記される。

- 時刻同期先
```
server ntp.example.com iburst
server ntp.example2.com
```

- うるう秒
```
leapsecmode [system | step | slew | ignore]
```

 - system:
    - うるう秒を挿入する場合、カーネルはシステムクロックがUTCの00:00:00になった時点で1秒戻します。うるう秒を削除する場合、システムクロックがUTCの23:59:59になった時点で1秒進みます。これは、システムドライバがうるう秒をサポートしている場合（macOS 12以前を除くすべての対応システム）、デフォルトのモードです。

 - step:
    - これはシステムモードに似ていますが、クロックのステップはカーネルではなく chronydによって行われます。システムモードで実行されるカーネルコードのバグを回避するのに役立ちます。システムドライバがうるう秒をサポートしていない場合、これはデフォルトのモードです。

 - slew:
    - るう秒が挿入された場合はUTC 00:00:00、うるう秒が削除された場合はUTC 23:59:59に開始されるスルーイングによって時計が修正されます。システム上で実行されるアプリケーションがシステム時刻のジャンプに敏感で、時計が長時間ずれても問題ない場合、システムモードやステップモードよりもこのモードが適している可能性があります。Linuxでは、 maxslewrateのデフォルト値を使用すると、修正には12秒かかります。

 - ignore:
    - うるう秒による補正は時計には適用されません。時計は、通常の動作中に新たな測定が行われ、推定されたオフセットに1秒の誤差が含まれるようになった時点で補正されます。

