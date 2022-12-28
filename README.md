# twins2mkdir

TWINS の履修科目を表す CSV ファイルから，科目ごとのディレクトリを作成するシェルスクリプト

## 依存関係

twins2mkdir は以下のコマンドを使用しているため，あらかじめインストールしておく必要があります．

- bash
- jq

## インストール

brew からインストールすることができます．

```sh
brew install yudukikun5120/twins2mkdir/twins2mkdir
```

## 使い方

1. TWINS の「履修登録・登録状況照会」から履修科目の CSV ファイルをダウンロードする

2. 科目ごとのディレクトリを作成するディレクトリへのパスを `COURSES_DIR` 変数として設定する

**bash の場合**

```bash
echo 'export COURSES_DIR="/path/to/dir"' >> ~/.bashrc && source ~/.bashrc
```

**zsh の場合**

```zsh
echo 'export COURSES_DIR="/path/to/dir"' >> ~/.zshrc && source ~/.zshrc
```

3. 第 1 引数に TWINS からダウンロードした CSV ファイルのパスを指定し，`twins2mkdir` を実行する

```bash
twins2mkdir /path/to/RSReferCsv.csv
```

4. 科目ごとのディレクトリが作成される

```bash
## まだディレクトリが存在しない場合
Created /path/to/dir/coursename

## すでにディレクトリが存在する場合
/path/to/dir/coursename already exists.
```

## 著作権表示

twins2mkdir は MIT ライセンスの下で公開されています．
詳しくは [LICENSE](LICENSE) をご覧ください．

また twins2mkdir は以下のライブラリを使用しています．

- [kdb-parse](https://github.com/Mimori256/kdb-parse)

詳しくは [NOTICE.md](NOTICE.md) をご覧ください．
