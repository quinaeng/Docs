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

・標準出力をファイルに出力する
```
[(￣∀￣)V]# ls 1> output.txt

/tmp/work
[(￣∀￣)V]# cat output.txt
output.txt
```

・標準エラー出力をファイルに出力する(存在しないコマンドを実行)

```
[(￣∀￣)V]# lll 2> output.txt

/tmp/work
[(￣∀￣)V]# cat output.txt
コマンド 'lll' が見つかりません。もしかして:
  command 'lli' from deb llvm-runtime (1:14.0-55~exp2)
  command 'llc' from deb llvm (1:14.0-55~exp2)
  command 'llt' from deb storebackup (3.2.1-2)
  command 'lld' from deb lld (1:14.0-55~exp2)
  command 'dll' from deb brickos (0.9.0.dfsg-12.2)
次を試してみてください: sudo apt install <deb name>
```

・標準出力と標準エラー出力をファイルに出力する

`2>&1`の別の書き方として`ls &> output.txt`がある。
```
[(￣∀￣)lll > output.txt 2>&1

/tmp/work
[(￣∀￣)V]# cat output.txt
コマンド 'lll' が見つかりません。もしかして:
  command 'llc' from deb llvm (1:14.0-55~exp2)
  command 'lli' from deb llvm-runtime (1:14.0-55~exp2)
  command 'llt' from deb storebackup (3.2.1-2)
  command 'dll' from deb brickos (0.9.0.dfsg-12.2)
  command 'lld' from deb lld (1:14.0-55~exp2)
次を試してみてください: sudo apt install <deb name>

/tmp/work
[(￣∀￣)ls > output.txt 2>&1

/tmp/work
[(￣∀￣)V]# cat output.txt
output.txt
```

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

・ファイル関連の演算子

```
-a ファイル: ファイルがあれば真
-b ファイル: ファイルがありブロックス特殊ファイルであれば真
-c ファイル: ファイルがありキャラクター特殊ファイルであれば真
-d ファイル: ファイルがありディレクトリであれば真
-e ファイル: ファイルがあれば真
-f ファイル: ファイルがあり通常のファイルであれば真
-g ファイル: ファイルがありSGID(特殊なアクセス権)であれば真
-G ファイル: ファイルがあり実行グループIDによる所有者であれば真
-h ファイル: ファイルがありシンボリックであれば真（-Lと同じ）
-k ファイル: ファイルがありステッキービットが設定されていれば真
-L ファイル: ファイルがありシンボリックであれば真（-hと同じ）
-O ファイル: ファイルがあり実行ユーザIDによる所有者であれば真
-p ファイル: ファイルがあり名前付きパイプ（named pipe）であれば真
-r ファイル: ファイルがあり読み取り可能であれば真
-s ファイル: ファイルがありサイズが0より大きければ真
-S ファイル: ファイルがありソケットであれば真
-t FD     : FD（ファイルディスクリプタ）が端末でオープンされていれば真
-u ファイル: ファイルがありSUID(特殊なアクセス権)であれば真
-w ファイル: ファイルがあり書き込み可能であれば真
-x ファイル: ファイルがあり実行可能であれば真
ファイルA -nt ファイルB: ファイルAがファイルBより新しければ真
ファイルA -ot ファイルB: ファイルAがファイルBより古ければ真
```

・数値比較演算子

```
数値1 -eq 数値2: 数値1と数値2が等しければ真
数値1 -ne 数値2: 数値1と数値2が等しくなければ真
数値1 -gt 数値2: 数値1が数値2より大きければ真
数値1 -lt 数値2: 数値1が数値2より小さければ真
数値1 -ge 数値2: 数値1が数値2以上であれば真
数値1 -le 数値2: 数値1が数値2以下であれば真
```

・文字列比較演算子

```
文字列: 文字列の長さが0より大きければ真
-n 文字列: 文字列の長さが0より大きければ真
-z 文字列: 文字列の長さが0であれば真
文字列A = 文字列B: 文字列Aと文字列Bが等しければ真
文字列A != 文字列B: 文字列Aと文字列Bが等しくなければ真
```

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

### pushd

### popd

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
historyコマンドの番号を指定してコマンドを実行する(!123で123番目のコマンドを実行する)
スクリプトのデーモン化
起動時の自動実行(rc-local)
/etc/environment
/etc/skel
```
## OneLiner

・「.conf」以外のファイルを削除する

```
ls | egrep -v .conf | paste -s | xargs rm -i
```

・現在のカレントディレクトリ配下でファイル

```
grep "文字列" `find ./ -type f`
```
