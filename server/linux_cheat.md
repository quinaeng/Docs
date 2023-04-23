# Linux cheat

## Bash Script

### 特殊変数

```
$0: 実行中のスクリプト名
$1〜$9: スクリプトに渡された引数
$#: スクリプトに渡された引数の数
$@: スクリプトに渡された引数をスペースで区切って展開したもの
$*: スクリプトに渡された引数を全てまとめたもの
$?: 直前に実行されたコマンドの終了ステータス
$$: スクリプトのプロセスID
```

### 配列

### リダイレクト

### Brace Expansion

```
touch {file1,file2,file3}.txt
touch file{1..3}.txt
touch {a..z}.txt
```

### ヒアドキュメント

### プロセス置換

コマンドの出力をファイルのように扱って別のコマンドに渡すことができる機能。
パイプラインを使用せずに複数のコマンドの出力を組み合わせることができる。

```
diff <(sort file1) <(sort file2)
```

### ワイルドカードを使ったテクニック


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

・配列の要素を一つずつ表示する。

```
#!/bin/bash
fruits=("apple" "banana" "orange" "grape")
for fruit in "${fruits[@]}"
do
  echo $fruit
done
```

### while

whileは、条件が正(true)の場合にループする。

・ファイル読み込み

```
#!/bin/bash
FILE="./testfile.txt"
while read line
do
  echo $line
done <$FILE
```

・1から10までインクリメントする(ワンライナー)

```
i=0; while (( i < 10 )); do (( i++ )); echo $i; done
```

・無限ループ

```
while true; do echo "loop";done
```

### until

### for

forは、定義された条件式の範囲内でループを行う。

・1から5の値を$iに代入して表示する

```
#!/bin/bash
for (( i=1; i<=5; i++ ))
do
  echo $i
done
```

・1から始まり5になるまでインクリメントする

```
#!/bin/bash
for (( i=1; i<=5; i++ ))
do
    echo $i
done
```

### case

### goto(ラベルに飛ばすやつ)

---

## Command

・shift

・basename

・dirname

・awk

・sed

・sort

### grep

```
# sample.txtの中で、catコマンドの出力に含まれる文字列を表示
grep -f <(cat pattern.txt) sample.txt
```
・cut

・uniq

・tr

・cat

```
cat << EOF > ./tet.txt
文字列
EOF
```

・rename

・getopt

・eval

・type

・trap
・wait
・printf
・tar
・zip
・set
・unset

### メモ

・実現したい機能
```
ファイルの世代管理
シェルスクリプトでオプション機能を付けたい
難読化
```
