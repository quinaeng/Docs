# KVMでスナップショットを取得する方法

## スナップショットの取得

- 仮想マシンのステータス確認
```
virsh list --all
````

- 仮想マシンを停止
```
virsh shutdown <VM>
```

- 仮想マシンのステータス確認
```
virsh list --all
````

- スナップショットを取得
```
virsh snapshot-create-as <VM> <snapshot_name> \
  "説明文（任意）" --disk-only --atomic
````

- シャットダウンせずにスナップショットを取得する場合
 > 基本は仮想マシンをシャットダウンしたほうが良い
```
virsh snapshot-create-as <VM> <snapshot_name> \
  "説明文" --disk-only --atomic --quiesce
```

- スナップショットの確認
```
virsh snapshot-list <vm_name>
```

## スナップショットの削除

- スナップショットの削除
```
virsh snapshot-delete <vm_name> <snapshot_name>
```

## リストア方法

- スナップショットからリストア
```
virsh snapshot-revert <VM> <snapshot_name>
```


