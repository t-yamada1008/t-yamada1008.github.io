---
layout: post
title:  "zshエラー解決: no such option: NO_typesettounset"
date:   2024-07-21 22:20:00 +0900
---

## エラー内容
ターミナルcdする時に以下のエラーメッセージが表示される

```sh
(eval):setopt:3: no such option: NO_typesettounset
```

## 解決手順
1. `/etc/shells` ファイルの編集

`sudo vim /etc/shells` コマンドで `/etc/shells` ファイルを開く。

```sh
# List of acceptable shells for chpass(1).
# Ftpd will not allow users to connect who are not using
# one of these shells.

/bin/bash
/bin/csh
/bin/dash
/bin/ksh
/bin/sh
/bin/tcsh
/bin/zsh
/usr/local/bin/zsh
```

2. デフォルトシェルの変更
- `chsh` コマンドを使ってデフォルトシェルを変更。

```sh
chsh -s /usr/local/bin/zsh
```

3. デフォルトシェルの変更
- シェルの再起動を行い、新しい設定を反映。

```sh
exec $SHELL -l
```
これで解決。

## setopt について

### `setopt` について
- setopt は、Zshシェルのオプションを設定するためのコマンド。
- Zshには多数のオプションがあり、これを使用することでシェルの動作をカスタマイズできる。
- オプションの設定方法と無効なオプションに関するエラーの原因について以下に説明。

### setopt コマンドの基本
- `setopt` コマンドを使用して、シェルのオプションを有効化。
- 例えば、HIST_IGNORE_SPACE オプションを有効にするには以下のようにする。

```sh
setopt: no such option: NO_typesettounset
```

このエラーは、`NO_typesettounset` というオプションが存在しないために発生する。
存在しないオプションを指定するとエラーが発生。当たり前だけど。

### オプションの確認
- Zshで使用可能なオプションの一覧を確認するには以下のコマンドを実行。

```sh
setopt
```

または、Zshのマニュアルページで詳細を確認できる。

```sh
man zshoptions
```
