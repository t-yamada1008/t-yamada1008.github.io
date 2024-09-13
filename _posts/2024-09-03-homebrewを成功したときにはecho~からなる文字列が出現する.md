---
layout: post
title: homebrewを成功したときにはecho~からなる文字列が出現する
date: 2024-09-03
categories: [TIL]
tags: [shell, zsh]
---

仕事でhomebrewを使って環境構築していた際に少し詰まった。
ただパスを入れていなかっただけなのだけど。

なお、結論としては成功メッセージもちゃんと読みましょうということである。
本来、brewを成功したときにはecho~からなる文字列が出現するのだから...。

```bash
$ echo 'export PATH="/opt/homebrew/bin:$PATH"' >> ~/.zshrc
```

こんな感じでね。

なお、.zshrcのリフレッシュも忘れないこと。

```bash
$ source ~/.zshrc
```

一応、whichでパスを確認しておくのも大事

```shell
% which brew
/usr/local/bin/brew
```