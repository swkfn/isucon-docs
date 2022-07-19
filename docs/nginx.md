# nginx

## 参考

- [nginxの基本設定を改めてちゃんと調べてみた](https://qiita.com/hclo/items/35f00b266506a707447e)
- https://www.mk-mode.com/blog/2014/04/13/nginx-file-discriptor-limit/
- https://github.com/Nagarei/isucon11-qualify-test/blob/b7e8f2667677831490d8e5966251633c14944015/setting/etc/nginx/nginx.conf

## 共通

```
# nginx の worker プロセス数  自動(CPU のコア数以上に設定しても意味がない）
worker_processes  auto;

# エラーログの出力場所
error_log  /var/log/nginx/error.log warn;

# nginx は 1 プロセス（Worker） で複数のリクエストをさばく
# https://www.mk-mode.com/blog/2014/04/13/nginx-file-discriptor-limit/
# https://www.1x1.jp/blog/2013/02/nginx_too_many_open_files_error.html
# worker プロセスが開くことのできる最大ファイル数（ファイルディスクリプタ）
# worker_connections の 3 ~ 4 倍程度にするとよい
# worker_rlimit_nofile 4096;

# PID の格納ファイル（ps 見たほうがはやい）
pid        /run/nginx.pid;

event {
    # nginx `全体` のクライアント接続数
    worker_connections  1024;
}

http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    # kernel の sendfile を利用する
    # ON にすると効率があがるが　プラットフォームなどによっては問題がおきるためその場合は off
    sendfile        on;

    # レスポンスヘッダとファイルを同時に送るようになる（ベンチの設定では点数下がる）
    # tcp_nopush     on;
    # tcp_nodelay on;

    # KeepAlive
    keepalive_timeout  65;

    # gzip
    # gzip on;
}

```

## alp ltsv

```
http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';
    log_format ltsv "time:$time_local"
                "\thost:$remote_addr"
                "\tforwardedfor:$http_x_forwarded_for"
                "\treq:$request"
                "\tstatus:$status"
                "\tmethod:$request_method"
                "\turi:$request_uri"
                "\tsize:$body_bytes_sent"
                "\treferer:$http_referer"
                "\tua:$http_user_agent"
                "\treqtime:$request_time"
                "\tcache:$upstream_http_x_cache"
                "\truntime:$upstream_http_x_runtime"
                "\tapptime:$upstream_response_time"
                "\tvhost:$host";

    access_log  /var/log/nginx/access.log  ltsv;
}
```

## 静的ファイル

静的ファイルは nginx で配信したほうがよい（スコアがあがる）
その設定はあとで追加する (server directive block )

キャッシュも静的ファイル or アプリケーション (memcached, redis) などで設定したほうがよい

## gzip

ファイルを圧縮してからクライアントにレスポンスを返す gzip は入れてみて点数を見る
（圧縮するのにもパワーがいるため。　たしか事前に圧縮する方法があるはず）
