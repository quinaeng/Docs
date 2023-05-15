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

・入力された値が数字かどうかを判定する

```
#!/bin/bash

read -p "Enter a value: " input

if [[ $input =~ ^[0-9]+$ ]]; then
    echo "Input is a number."
else
    echo "Input is not a number."
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

```
#!/bin/bash

read -p "Enter a fruit name: " fruit

case $fruit in
    "apple")
        echo "Selected fruit: Apple"
        ;;
    "banana")
        echo "Selected fruit: Banana"
        ;;
    "orange")
        echo "Selected fruit: Orange"
        ;;
    *)
        echo "Unknown fruit"
        ;;
esac
```

### goto(ラベルに飛ばすやつ)

---

## Command

### shift

### basename

### dirname

### awk

・オプション

```
-F fs: フィールドセパレータを指定する。fsにはセパレータを指定します。デフォルトは空白文字（スペースやタブ）です。例えば、-F,を指定すると、カンマ区切りのデータを処理することができます。
-v var=value: AWKの変数に値を代入します。varは変数名、valueは値を指定します。例えば、-v var=10を指定すると、変数varに値10が代入されます。
-f scriptfile: AWKスクリプトをファイルから読み込みます。scriptfileには、AWKスクリプトが記述されたファイル名を指定します。
-F fs -v var=value -f scriptfile: 上記のオプションを複数指定することができます。
```


・3行目から5行目を表示する

```
awk 'NR==3,NR==5' file.txt
```

・偶数行のみ表示する

```
awk 'NR%2==0' file.txt
```

・カンマ区切りで1つ目の値を取得する

```
awk -F',' '{print $1}' file.txt
```

・カンマ区切りでフィールドが何個あるかを表示する
3が表示される
```
echo "a,b,c" | awk -F',' '{print NF}'
```

・すべてを初期化する。※すべて「Hello World」で表示される。

```
awk 'BEGIN {print "Hello World"}' file.txt
```

・処理した行番号を表示する

```
awk 'END {print NR}' file.txt
```

・2つ目の引数の内容が"OK"の場合、1つ目の引数を、NGの場合は空白を表示する。

```
awk -F',' '{print ($2 == "OK" ? $1 : "")}' foo.txt
```


### sed

デリミタは/、|、#が使われることが多い。


・3行目を「after」という文字列に置換する。

```
sed '3c after' <ファイル>
```

・3行目から5行目のみを全置換の対象とする。

```
sed '3,5s/abc/ABC/g'
```

・3行目から5行目を表示する

```
sed -n '3,5p' file.txt
```

・testをtest2に文字列置換する

```
sed -i 's/test/test2/g' file.txt
```

・1行目から5行目を削除

```
sed '1,5d' file.txt
```

・1行目から5行目以外を削除

```
sed '1,5!d' file.txt
```

・n行目に行を追加

```
後で調べる
```

・アルファベット小文字を大文字に置換する。

```
sed 's/.\+/\U\0/'
```

・アルファベット大文字を小文字に置換する。


### sort



### grep

・任意の文字列に一致する文字列を表示しない

```
grep -v "LINUX" <ファイル> 
```

・拡張正規表現を利用した任意の文字列に一致する文字列を表示する。

```
grep -E 'linux|LINUX|Linux' <ファイル>
```

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


### tac

・ファイルを逆順に表示する。(catコマンドの逆)

```
tac file.txt
```


### find

・任意のファイルの更新日時よりも後に更新したファイルやディレクトリを検索する。

```
find <パス> -newer <ファイル>
```

・12時間以内に変更されたファイルを検索する。

```
find <パス> -mmin -720
```

・12時間以上前に変更されたファイルを検索する。

```
find <パス> -mmin +720
```

・ファイルサイズで検索する(10Byteより大きい)

```
find <パス> -size +10c
```

・ファイルサイズで検索する(10Byte未満)

```
find <パス> -size -10c
```

### rsysnc

・オーナー・グループ・パーミッション・タイムスタンプをそのままコピーする。

```
rsync -avh src/ dst/
```

・差分(追加ファイル、更新日時)コピーする。

```
rsync -auvh src/ dst/
```

・差分(チェックサム)コピーする。

```
rsync -acuvh src/ dst/
```

・リモートに先に送信(転送中のデータを圧縮する)

```
rsync -avh --compress src/testdir root@192.168.10.199:/root/work/dst
```

※rsyncコマンドでディレクトリをコピーする場合は、ディレクトリ名の最後に/を入れないようにする。

・ファイル名が「.mp3」のものをコピーする。サブディレクトリ内も「.mp3」のファイルのみコピーする。

```
rsync -avh --include='*.mp3' --include='*/' --exclude='*' src/ dst/
```

### tshark

・キャプチャファイルのサイズが1GBをになるか、キャプチャ時間が1日になった場合に停止する。 test.pcapというファイル名で保存する。

```
tshark -i ens33 -w /tmp/capture.pcap -a duration:86400 -b filesize:1000000
```

### tcpdump

・送信元と宛先のアドレスを指定してパケットキャプチャをファイルに保存する

```
tcpdump -i ens33 src 192.168.10.200 and dst 192.168.10.200 -w /tmp/packet.pcap
```

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
特定のディレクトリ内のファイル名の後ろに_yyyymmddをつける(rename)
```
## OneLiner

・「.conf」以外のファイルを削除する

```
ls | egrep -v .conf | paste -s | xargs rm -i
```

・現在のカレントディレクトリ配下でファイル

```
grep "文字列" `find ./ -type f`
(grep -r "文字列" .)
```

・カレントディレクトリ配下のファイルを移動する

```
find . -type f -print0 | xargs -0 mv -t /mnt/backup
```

・差分比較

```
diff -y <(LC_COLLATE=C sort file1.txt) <(LC_COLLATE=C sort file2.txt)
```

・重複文字列とその数を表示する

```
cat file.txt | sort | uniq -c | awk '{ print $2, $1 }'
```

・拡張子「.jpg」を「.jpeg」にする。(要確認)

```
ls 1 | sed -r "s/(.*)\.jpg$/mv & \1.jpeg/" | bash
```

・インターフェース名とIPアドレスを取得する

```
ip addr | awk '/^[0-9]+:/ { interface=$2 } /inet / { print interface, $2 }'
```

## 参考


[俺的備忘録 〜なんかいろいろ〜](https://orebibou.com/ja/documents/shellgei/)

[https://twitter.com/minyoruminyon](https://twitter.com/minyoruminyon)
