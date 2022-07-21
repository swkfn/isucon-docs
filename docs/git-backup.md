
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

上記の isucon12-q に利用するファイルを追加・登録し git 管理する。

`/etc` (mysql nginx ...) 系と DB 設定ファイル(`CREATE TABLE` のような DDL)は git に直接は追加しない。
`/etc` の重要なファイル `mysql/mysql.conf.d/my.cnf` のみを手動でコピーして、 `isuconXX-q` 内に手動で貼り付ける。
よって、 ローカル PC の VSCode などで編集しリモートに push したら、 `isuconXX-q` 内の `my.cnf` の内容を手動で `/etc` 以下に貼り付ける。
このように、 `/etc` 系は少しでも変な操作をすると一瞬で壊れてしまう（権限まわりも 非常に危険）。
よって、重要なファイルのみ手動でコピー・反映する。

`webapp` (言語実装) は複数のバックアップをとったあとで、シンボリックリンクを貼り直接 git で管理する。
node_modules など不必要なファイルは管理しない。

