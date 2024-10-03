---
layout: post
title: after_initializeについて
date: 2024-10-03
categories: [TIL]
tags: [ruby, rails, gpt]
---

## ひとこと

業務でafter_initializeを使ったのだけど、before_saveぐらいしかコールバックは使ったことがなかったのでメモ。

## GPT解説

`after_initialize` は、Ruby on Rails の ActiveRecord におけるコールバックメソッドの一つです。このメソッドは、モデルのオブジェクトが初期化された直後に実行されます。つまり、新しいオブジェクトが生成されたときや、データベースから既存のレコードがロードされたときに呼び出されます。

**主な用途:**

- **デフォルト値の設定:** モデルの属性にデフォルト値を割り当てたい場合。
- **初期設定の実行:** オブジェクト生成時に特定の処理を行いたい場合。

**使用例:**

```ruby
class User < ApplicationRecord
  after_initialize :set_default_role

  private

  def set_default_role
    self.role ||= 'guest'
  end
end
```

この例では、`User` オブジェクトが初期化された際に `set_default_role` メソッドが呼び出され、`role` 属性が未設定であれば自動的に `'guest'` が割り当てられます。

**注意点:**

- **新規作成とロード時の両方で呼び出される:** `after_initialize` はオブジェクトの新規作成時だけでなく、データベースからロードされたときにも実行されます。そのため、処理を新規作成時に限定したい場合は、`new_record?` メソッドを使って条件分岐を行う必要があります。

  ```ruby
  def set_default_role
    self.role ||= 'guest' if new_record?
  end
  ```

**まとめ:**

`after_initialize` は、オブジェクトの初期化直後に特定の処理を行いたい場合に便利なコールバックです。しかし、その特性上、意図しないタイミングでメソッドが呼び出される可能性もあるため、使用時には注意が必要です。