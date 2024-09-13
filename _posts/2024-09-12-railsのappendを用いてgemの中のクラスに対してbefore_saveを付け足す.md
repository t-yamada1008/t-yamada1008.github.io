---
layout: post
title: railsのappendを用いてgemの中のクラスに対してbefore_saveを付け足す
date: 2024-09-12
categories: [TIL]
tags: [rails, ruby, gpt]
---

今日の仕事であったケース。
railsのappendを用いてgemの中のクラスに対してbefore_saveを付け足すような感じの事例があったので、GPTに尋ねてみる。

`append`というメソッドはRuby on Railsのコア機能にはありませんが、`append`のような動作をする目的で使われる方法や、そのような動作を実現するための一般的な方法を説明します。特に、外部のgem内のクラスに`before_save`のようなコールバックを追加する場合に使えるテクニックについて説明します。

### 1. `before_save` コールバックの追加

`before_save`はRailsのActiveRecordで提供されるコールバックで、レコードが保存される直前に実行されます。これを外部のgemのクラスに対して追加する場合、Rubyのオープンクラス（`open class`）の特徴を利用して、そのクラスに直接コールバックを追加することができます。

#### 例：gemのクラスに`before_save`を追加する

外部のgemが提供するクラスに対して`before_save`を追加したい場合、次のようにそのクラスを再オープンしてコールバックを追加します。

##### 例として、外部のgemが次のようなモデルを持っているとします：

```ruby
# 外部のgemのクラス（例: app/models/third_party_model.rb）
class ThirdPartyModel < ApplicationRecord
  # もともとの定義
end
```

このクラスに対して、`before_save`を追加したいとします。

##### クラスの再オープン

以下のようにして、Railsアプリケーション内でそのクラスを再オープンし、`before_save`を追加します。

```ruby
# config/initializers/third_party_model_extension.rb
ThirdPartyModel.class_eval do
  before_save :custom_before_save_callback

  private

  def custom_before_save_callback
    # 保存前に実行したいカスタムロジック
    puts 'This is a custom before_save callback!'
  end
end
```

#### ポイント

- **`class_eval`の使用**: Rubyの`class_eval`メソッドを使用して、既存のクラスを再オープンし、追加のメソッドやコールバックを定義します。
- **`before_save`の追加**: この再オープンしたクラスの中で`before_save`を追加し、必要なロジックを定義します。

### 2. その他の方法

場合によっては、より構造化された方法を使いたいこともあります。例えば、以下の方法が考えられます。

#### モジュールを使った`prepend`の使用

`prepend`を使うと、既存のクラスにメソッドを追加する際に、元のメソッドの前に新しいメソッドを実行することができます。これにより、よりクリーンな方法でメソッドを拡張できます。

```ruby
# config/initializers/third_party_model_extension.rb
module ThirdPartyModelExtension
  def self.prepended(base)
    base.before_save :custom_before_save_callback
  end

  def custom_before_save_callback
    # 保存前に実行したいカスタムロジック
    puts 'This is a custom before_save callback!'
  end
end

ThirdPartyModel.prepend ThirdPartyModelExtension
```

#### ポイント

- **`prepend`の使用**: `prepend`を使うことで、元のクラスにメソッドを追加し、追加したメソッドを既存のメソッドの前に呼び出すことができます。
- **モジュールの使用**: モジュールを使って追加のメソッドやコールバックを定義することで、コードがより整理されて読みやすくなります。

### 3. 注意点

- **外部gemのアップデート**: gemがアップデートされた場合、クラスの構造が変わる可能性があるため、再オープンや`prepend`の使用方法が正しく動作しなくなることがあります。
- **パフォーマンス**: 大規模なクラスを何度も再オープンしたり、多くのコールバックを追加すると、パフォーマンスに影響を与えることがあります。
- **依存関係の管理**: 追加したコードが外部のgemの実装に依存するため、gemの内部実装が変わった場合にエラーが発生する可能性があります。

### まとめ

Railsで外部gemのクラスに対して`before_save`を追加するには、Rubyのオープンクラスの特性を活かして`class_eval`や`prepend`を使用するのが一般的です。これにより、既存のクラスの機能を柔軟に拡張し、自分のアプリケーションのニーズに合わせてカスタマイズできます。
