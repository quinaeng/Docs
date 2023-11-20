・ログイン
```
# az login
```

# 仮想ネットワーク

・VNetの作成
```
# az network vnet create --resource-group <リソースグループ名> --name <VNet名> --address-prefixes <xxx.xxx.xxx.xxx/mask>
```

・VNetの削除
```
# az network vnet delete --resource-group <リソースグループ名> --name <VNet名>
```

・VNetの一覧
```
# az network vnet list --query '[].{Name:name, ResourceGroup:resourceGroup}' --output tablee
```

・サブネットの作成
```
# az network vnet subnet create --resource-group <リソースグループ名> --vnet-name <VNet名> --name <サブネット名> --address-prefixes <xxx.xxx.xxx.xxx/mask>
```

・サブネットの削除
```
# az network vnet subnet delete --resource-group <リソースグループ名> --vnet-name <VNet名> --name <サブネット名>
```

・サブネットの一覧
```
# az network vnet subnet list --resource-group <リソースグループ名> --vnet-name <VNet名> --output table
```

# 仮想マシン

・VMの作成

※パブリックIPアドレスはデフォルトで付与されるので設定されないようする。
```
# az vm create \
  --resource-group rg-kamizato \
  --name <VM名> \
  --image Ubuntu2204 \
  --location japanwest \
  --storage-sku standard_lrs \
  --accelerated-networking true \
  --admin-username <ユーザ名> \
  --admin-password <パスワード> \
  --size Standard_DS2_v2 \
  --public-ip-address "" \
  --vnet-name <VNet名> \
  --subnet <サブネット名> \
  --tags <キー:バリュー>
```

・VMの起動
```
# az vm start -g <リソースグループ名> -n <VM名>
```

・VMの停止

※deallocateでリソース割り当てを解除することでコストがかからなくなります。stopよりも起動時に時間がかかりますがデータ自体は保持されます。
```
# az vm stop -g <リソースグループ名> -n <VM名>
# az vm deallocate -g <リソースグループ名> -n <VM名>
```

・VMの削除
```
# az vm delete -g <リソースグループ名> -n <VM名>
```

・VMの一覧表示
```
# az vm list --show-details --output table
```

# ディスク(未検証)

・ディスクの作成
```
# az disk create --resource-group <リソースグループ名> --name <ディスク名> --size-gb <ディスクサイズGB> --sku <ディスクSKU>
```

・VMにディスクを割り当てる
```
# az vm disk attach --resource-group <リソースグループ名> --vm-name <VM名> --name <ディスク名> --size-gb <ディスクサイズGB> --sku <ディスクSKU>
```

・VMのディスクを切り離す
```
# az vm disk detach --resource-group <リソースグループ名> --vm-name <VM名> --name <ディスク名>
```

・VMのスナップショットを作成する
```
# az snapshot create --resource-group <リソースグループ名> --name <スナップショット名> --source <ディスクまたはVMのID>
```

・VMの即時バックアップを作成する

# ロードバランサー

・Azure LBを作成する

・バックエンドのVMを追加する

・バックエンドのVMを削除する

・Azure LBを削除する

# ネットワークセキュリティグループ

・NSGを作成する

・NSGを削除する
```
# az network nsg delete --resource-group <リソースグループ名> --name <NSG名>
```

・NSGの一覧表示
```
# az network nsg list --output table
```

・NSGの規則の確認
```
# az network nsg rule list -g <リソースグループ名> --nsg-name <NSG名> --include-default --output table
```

・NSGの受信規則を追加する

・NSGの受信規則を削除する

・NSGの送信規則を追加する

・NSGの送信規則を削除する

・NSGをVNetに割り当てる

・NSGをVNetから切り離す

・NSGをVMから切り離す

# DNSゾーン

・DNSゾーンの作成

・DNSゾーンの削除

# コンテナレジストリ(ACR)

# Kubernetes(AKS)

