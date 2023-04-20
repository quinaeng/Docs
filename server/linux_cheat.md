# Linux cheat

## Bash Script

### if

・コメントアウト機能

${変数:<開始位置>:<開始位置からn文字取り出す}
```
if [ "${var:0:1}" = "#" ]; then
  echo "先頭に#がついています。"
else
  echo "先頭に#がついていません。"
fi
```

### for

### while

### for

### case

### goto(ラベルに飛ばすやつ)

### リダイレクトについて
---

## Command

・shift

・basename

・dirname

・awk

・sed

・sort

・grep

・cut

・uniq

・tr

・cat
```
cat << EOF > ./tet.txt
文字列
EOF
```

### メモ

・実現したい機能
```
ファイルの世代管理
シェルスクリプトでオプション機能を付けたい
```
