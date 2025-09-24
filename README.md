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
[root@localhost sds]#
[root@localhost sds]# parted /dev/sda print
モデル: VMware Virtual disk (scsi)
ディスク /dev/sda: 1319GB
セクタサイズ (論理/物理): 512B/512B
パーティションテーブル: gpt
ディスクフラグ:

番号  開始    終了    サイズ  ファイルシステム  名前                  フラグ
 1    1049kB  630MB   629MB   fat32             EFI System Partition  boot, esp
 2    630MB   1704MB  1074MB  xfs
 3    1704MB  40.8GB  39.1GB  xfs
 4    40.8GB  45.1GB  4295MB  linux-swap(v1)                          swap
 5    45.1GB  1145GB  1100GB                                          lvm

[root@localhost sds]#
[root@localhost sds]# pvdisplay
  --- Physical volume ---
  PV Name               /dev/sda5
  VG Name               vg00
  PV Size               1.00 TiB / not usable 4.00 MiB
  Allocatable           yes
  PE Size               4.00 MiB
  Total PE              262145
  Free PE               1
  Allocated PE          262144
  PV UUID               Y6drBa-rs1K-RKfC-8xT0-EboN-0OQD-yzBMEM

  --- Physical volume ---
  PV Name               /dev/sdb2
  VG Name               vg01
  PV Size               <200.01 GiB / not usable 4.00 MiB
  Allocatable           yes
  PE Size               4.00 MiB
  Total PE              51201
  Free PE               1
  Allocated PE          51200
  PV UUID               OnzLeX-jPKM-vpNw-vOEi-gxq9-PCrJ-NByAKe

[root@localhost sds]#
[root@localhost sds]# vgdisplay
  --- Volume group ---
  VG Name               vg00
  System ID
  Format                lvm2
  Metadata Areas        1
  Metadata Sequence No  2
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                1
  Open LV               1
  Max PV                0
  Cur PV                1
  Act PV                1
  VG Size               1.00 TiB
  PE Size               4.00 MiB
  Total PE              262145
  Alloc PE / Size       262144 / 1.00 TiB
  Free  PE / Size       1 / 4.00 MiB
  VG UUID               0dCcGc-oJLW-XgyX-JclT-Iwmi-2U6I-S4s6KG

  --- Volume group ---
  VG Name               vg01
  System ID
  Format                lvm2
  Metadata Areas        1
  Metadata Sequence No  2
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                1
  Open LV               1
  Max PV                0
  Cur PV                1
  Act PV                1
  VG Size               200.00 GiB
  PE Size               4.00 MiB
  Total PE              51201
  Alloc PE / Size       51200 / 200.00 GiB
  Free  PE / Size       1 / 4.00 MiB
  VG UUID               0166Y8-scj6-a76L-vv1i-kaXC-H7hx-rIvaC4

[root@localhost sds]#
[root@localhost sds]# lvdisplay
  --- Logical volume ---
  LV Path                /dev/vg00/lv_data
  LV Name                lv_data
  VG Name                vg00
  LV UUID                dih1Cn-PnHw-eMYm-6xog-H0p8-c0zK-k06Uv3
  LV Write Access        read/write
  LV Creation host, time localhost.localdomain, 2025-09-24 15:57:59 +0900
  LV Status              available
  # open                 1
  LV Size                1.00 TiB
  Current LE             262144
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     8192
  Block device           253:0

  --- Logical volume ---
  LV Path                /dev/vg01/lv_data
  LV Name                lv_data
  VG Name                vg01
  LV UUID                NS1wQQ-ZLl1-1d7j-UeXC-Ioi0-VLYV-gjVccB
  LV Write Access        read/write
  LV Creation host, time localhost.localdomain, 2025-09-24 16:09:46 +0900
  LV Status              available
  # open                 1
  LV Size                200.00 GiB
  Current LE             51200
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     8192
  Block device           253:1

[root@localhost sds]#


```
