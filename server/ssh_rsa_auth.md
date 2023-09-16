- SSHクライアントでの作業

・公開鍵の作成
```
# ssh-keygen -t rsa -b 4096
Enter file in which to save the key (/root/.ssh/id_rsa):<エンターを入力>
Enter passphrase (empty for no passphrase):<エンターを入力>
Enter same passphrase again:<エンターを入力>
```
・ディレクトリの権限を変更
```
# chmod 700 ~/.ssh
```

・公開鍵をSSHサーバに転送
```
# ssh-copy-id -i ~/.ssh/id_rsa.pub user@192.168.10.22
```

- サーバでの作業


・権限を変更
```
# chmod 700 ~/.ssh
# chmod 600 ~/.ssh/authorized_keys
```

・sshd_configのバックアップ
```
# cp -ip /etc/ssh/sshd_config /etc/ssh/sshd_config.org
```

・sshdの設定変更
```
# vi /etc/ssh/sshd_config
```

```
PasswordAuthentication no
AuthorizedKeysFile      .ssh/authorized_keys
```

・サービス再起動
```
# systemctl restart sshd
# systemctl status sshd
```
