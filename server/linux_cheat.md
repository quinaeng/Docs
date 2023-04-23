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

・動作確認のためのスクリプト

```
#!/bin/bash

echo "$0"
echo "$1"
echo "$2"
echo "$3"
echo "$#"
echo "$@"
echo "$*"
echo "$?"
echo "$$"
```

```
[(￣∀￣)V]# bash test.sh param1 param2 param3
test.sh
param1
param2
param3
3
param1 param2 param3
param1 param2 param3
0
7266
```

・$@と$\*の違いは$@は、引数を各引数として展開され$\*は一つの引数として展開される。

```
#!/bin/bash

echo "Using \$*"
for arg in "$*"; do
    echo $arg
done

echo "Using \$@"
for arg in "$@"; do
    echo $arg
done
```

```
[(￣∀￣)V]# bash test.sh param1 param2 param3
Using $*
param1 param2 param3
Using $@
param1
param2
param3
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

・$iが10以下の場合インクリメントする

```
#!/bin/bash
i=0
while [ $i -le 10 ]
do
        echo $i
        i=$(expr $i + 1)
done
```

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

ポイント:
whileの条件式を括弧「()」で書く場合とブラケット「[]」で各場合の違いは、括弧の場合は変数がサブシェルによって実行されその結果を条件としてwhileの実行判断が行われる。
ブラケットの場合は、現在のシェルで実行された結果をもとにwhileの実行判断が行われる。


### case

### goto(ラベルに飛ばすやつ)

---

## Command

### shift

### basename

### dirname

### awk

### sed

### sort

### grep

```
# sample.txtの中で、catコマンドの出力に含まれる文字列を表示
grep -f <(cat pattern.txt) sample.txt
```

### cut

### uniq

### tr

### cat

```
cat << EOF > ./tet.txt
文字列
EOF
```

### rename

### getopt

### eval

### type

### trap

### wait

### printf

### tar

### zip

### set

### unset

### メモ

・実現したい機能

```
ファイルの世代管理
シェルスクリプトでオプション機能を付けたい
難読化
```
