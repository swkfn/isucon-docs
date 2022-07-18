
# 参考リンク

- http://tatamo.81.la/blog/2018/09/16/isucon8-qual-2/
- [ssh-agentを利用して、安全にSSH認証を行う](https://zenn.dev/naoki_mochizuki/articles/ce381be617cd312ffe7f)
- [ISUCON SSH チートシート](https://github.com/sonots/isucon3_cheatsheet/blob/master/01.ssh.md)
  - ssh-agent を用いれば リモートでも github にアクセスできる

# SSH

[ISUCON 11 予選当日マニュアル](https://gist.github.com/ockie1729/53589a0e8c979198b6231d8599153c70#%E7%AB%B6%E6%8A%80%E7%92%B0%E5%A2%83%E6%A7%8B%E7%AF%89%E3%81%A8%E6%8E%A5%E7%B6%9A)

上記を参考にすると、以下のような環境が与えられる。

- リモートマシンである EC2 インスタンス が 3 台 (isuA, isuB, isuC)
- 各インスタンスには、「GitHub に予め登録しておいた SSH 公開鍵」があらかじめ登録されている
  - 各インスタンスにおいて、 isucon ユーザ の `~/.ssh/authorized_keys` に 「GitHub に登録しておいた SSH 公開鍵」 が登録されている

よって、ローカルマシン(ここでは家にある mac を想定)のターミナルからは以下のようにして接続できる（はず）。
ただし、 GitHub に登録しておいた鍵が `id_rsa`, `id_rsa.pub` であることを想定した書き方になっている。

```shell
ssh -i ~/.ssh/id_rsa isucon@{isuA,B,C の PublicIP Address}
```

PublicIP Address を 3 台分けて指定してリモートマシンに接続することは面倒である。
よって、以下のようにローカルマシンの `~/.ssh/config` に 3 台のマシン情報を登録しておくと良い。
IdentifyFile に利用する秘密鍵へのパスを指定する（別の名前の秘密鍵を利用している場合は、その名前の秘密鍵を書いておく）。

```
ServerAliveInterval 60
ServerAliveCountMax 5

Host isuA
    HostName xx.xx.xx.x1
    User isucon
    IdentityFile ~/.ssh/id_rsa
    ForwardAgent yes

Host isuB
    HostName xx.xx.xx.x1
    User isucon
    IdentityFile ~/.ssh/id_rsa
    ForwardAgent yes

Host isuC
    HostName xx.xx.xx.x1
    User isucon
    IdentityFile ~/.ssh/id_rsa
    ForwardAgent yes
```

上記を準備しておけば 以下でリモートサーバ 3 台にログインできる。

```shell
ssh isuA
ssh isuB
ssh isuC
```

# GitHub

ローカルマシン (手元の mac)では当然 git & GitHub を利用できる。
問題はリモートマシンで GitHub を利用する方法である。

ここでは ssh-agent を利用する方法を記載する。    
https://zenn.dev/naoki_mochizuki/articles/ce381be617cd312ffe7f

はじめに、 ローカルマシンで ssh-agent に GitHub で利用する SSH 鍵を登録する。
ganyariya は `~/.ssh/id_rsa.pub` を GitHub に公開鍵として登録し、秘密鍵は `~/.ssh/id_rsa` を利用している。

よって、以下のようにして秘密鍵をローカルマシンで登録する。

```shell
ssh-add ~/.ssh/id_rsa
```

続いて、上記の `SSH` の節で準備しておいた `~/.ssh/config` に `ForwardAgent yes` を isuA, isuB, isuC ごとに記載しておく。

あとは `ssh isuA` でリモートマシンにログインするだけでよい。
`ssh-agent` が自動でリモートマシンにも `~/.ssh/id_rsa` (GitHub にアクセスする秘密鍵) を引き継いでくれる。
よって、リモートマシンにも `~/.ssh/id_rsa` 情報があるため、そのまま GitHub を利用できる。

リモートマシンで以下が表示されれば、接続できている。

```shell
ssh -T git@github.com
Warning: Permanently added the ECDSA host key for IP address '52.69.186.44' to the list of known hosts.
Hi ganyariya! You've successfully authenticated, but GitHub does not provide shell access.
```

