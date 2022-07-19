
# Git Backup

リモートマシンのソースコードや設定ファイルを Git に追加して Private GitHub リポジトリに入れる。

## はじめに

`isuconXX-q` というリポジトリを だれかの private GitHub に用意しておく。

## リモートマシンでソースコードを登録する

```shell
cd /home/isucon
mkdir isucon12-q
cd isucon12-q
```

上記の isucon12-q に利用するファイルを追加・登録していく。
`/home/isucon/isucon12-q` に [git-add.sh](/script/git-add.sh) を copy して実行する。
これで重要なファイルをバックアップし、かつシンボリックリンクをはり、 isucon12-q 以下を git 管理すればよくなる。

