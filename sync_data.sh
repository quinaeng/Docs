#!/bin/bash

source_data='/data/data'
target_data='sds@192.168.10.231:/data/smzlog01_data/'
log_file='/var/log/sync_data.log'
lock_file='/var/log/sync_data.lock'

# スクリプトが実行中かどうか確認
exec 200>"${lock_file}"
flock -n 200 || {
    echo "$(date '+%Y-%m-%d %H:%M:%S') スクリプトが実行中のためスキップしました。" >> "${log_file}"
    exit 1
}

# 同期実行
rsync -azu --delete "${source_data}" "${target_data}"

