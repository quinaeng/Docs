#!/bin/bash

source_data='/data/data/'
target_data='sds@192.168.10.231:/data/smzlog02_data/'
log_file='/var/log/sync_data.log'
lock_file='/var/log/sync_data.lock'
base_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exclude_file="${base_dir}/exclude.txt"

# スクリプトが実行中かどうか確認
exec 200>"${lock_file}"
flock -n 200 || {
    echo "$(date '+%Y-%m-%d %H:%M:%S') スクリプトが既に実行中のためスキップしました。" >> "${log_file}"
    exit 1
}

echo "$(date '+%Y-%m-%d %H:%M:%S') スクリプトを開始しました。" >> "${log_file}"

# rsync 実行
if [ -f "${exclude_file}" ]; then
    rsync -azu --delete --exclude-from="${exclude_file}" \
        --out-format="%o %n%L %i" "${source_data}" "${target_data}" >> "${log_file}" 2>&1
else
    rsync -azu --delete \
        --out-format="%o %n%L %i" "${source_data}" "${target_data}" >> "${log_file}" 2>&1
fi

rsync_status=$?

if [ ${rsync_status} -eq 0 ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') スクリプトが正常に終了しました。" >> "${log_file}"
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') スクリプトがエラーで終了しました (rsync exit code: ${rsync_status})。" >> "${log_file}"
fi
