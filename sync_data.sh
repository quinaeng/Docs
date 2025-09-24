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
echo "$(date '+%Y-%m-%d %H:%M:%S') スクリプトが実行しました。" >> "${log_file}"
rsync -azu --delete --out-format="%o %n%L %i" "${source_data}" "${target_data}" >> "${log_file}"
echo "$(date '+%Y-%m-%d %H:%M:%S') スクリプトが終了しました。" >> "${log_file}"

# %t : 実行時刻（rsync が処理したタイムスタンプ）
# %o : 操作の種類 (send, recv, del. など)
# %i : 変更インジケータ (更新理由を示すフラグ)
# %n : ファイル名
# %L : シンボリックリンクの参照先

# --- 変更インジケータの意味 ---
# 先頭文字:
#   > : 送信元から受信先に転送された
#   < : 受信側から送信元にコピー（通常は出ない）
#   c : 新規作成された
#   * : 特殊イベント (例: エラーやバッチ処理)

# 2文字目: ファイル種別
#   f : 通常ファイル
#   d : ディレクトリ
#   L : シンボリックリンク
#   D : デバイスファイル

# 3文字目以降は属性の変更理由
#   s : サイズが変更された
#   t : タイムスタンプ (mtime) が変更された
#   p : パーミッションが変更された
#   o : 所有者 (uid) が変更された
#   g : グループ (gid) が変更された
#   a : ACL が変更された
#   x : 拡張属性が変更された
#   . : その属性に変更なし
