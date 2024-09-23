---
layout: post
title: Railsでのtruncate
date: 2024-09-23
categories: [TIL]
tags: [ruby, rails, gpt]
---

このメソッドってRubyの組み込みだっけ、Railsだっけというのが時たまある。
そのうちの1つがこれ。

まあでも最後に省略記号が付与されるあたりはActiveSupport拡張かなとも思う。
以下GPT引用。

## truncateについて

Rubyには、直接的に「`truncate`」という名前の標準メソッドはありませんが、いくつかの文脈で「truncate」という操作を行うメソッドや方法があります。

### 1. **文字列のトランケート**
Rubyでは、文字列を指定された長さに切り詰める（トランケートする）ために`String`クラスに`String#slice`や`String#truncate`メソッドを使うことができます。

#### `String#truncate`メソッド（ActiveSupport）
`String#truncate`は、Ruby on Railsに含まれる`ActiveSupport`の拡張メソッドです。このメソッドを使うと、指定した長さに文字列を切り詰めて、続きがあることを示すために省略記号（デフォルトで`"..."`）を付加できます。

例：
```ruby
str = "This is a long string that needs to be truncated."
truncated_str = str.truncate(20)
puts truncated_str  # => "This is a long st..."
```

上記の例では、文字列が20文字に切り詰められ、末尾に省略記号が付きます。

### 2. **ファイルのトランケート**
Rubyの`File`クラスには、ファイルのサイズを指定したバイト数に切り詰めるための`truncate`メソッドが存在します。このメソッドを使用することで、ファイルの内容を指定したサイズまで縮小することができます。

例：
```ruby
File.open('example.txt', 'w') { |file| file.write("This is some content.") }

File.open('example.txt', 'r+') do |file|
  file.truncate(4)
end

puts File.read('example.txt')  # => "This"
```

この例では、ファイルの内容が4バイトに切り詰められ、結果として"Thi"という文字列がファイルに残ります。

### まとめ
- **Rails/ActiveSupportの`String#truncate`** で文字列を切り詰めることができる。
- **`File#truncate`** でファイルの内容を切り詰めることができる。

標準のRubyには文字列用の`truncate`メソッドはありませんが、Railsプロジェクトで使われる`ActiveSupport`にはこのメソッドが含まれています。