---
layout: post
title: Rspec時にassertとwithinで秒数を丸める
date: 2024-09-25
categories: [TIL]
tags: [ruby, rails, rspec, gpt]
---

## ひとこと

今日の仕事でcreated_atを使ってアレコレした際に時刻で躓いたため。
結局運用的には時刻が一致する必要はなくて、少し前に判定がずれていても問題なかった。

その時に使ったのがbe_within。そうしたらなんかついてきた。

### `assert_in_delta`を使用したテスト

`assert_in_delta`は、2つの数値（または時刻）が指定した誤差範囲内にあることを検証します。

```ruby
require 'test_helper'

class TimeComparisonTest < ActiveSupport::TestCase
  def test_time_within_seconds
    time1 = Time.now
    time2 = time1 + 5.seconds  # 5秒後

    allowed_difference = 10.seconds  # 許容する誤差（10秒）

    assert_in_delta time1, time2, allowed_difference, "時刻の差が許容範囲を超えています"
  end
end
```

この例では、`time1`と`time2`の差が**10秒以内**であることを確認しています。

---

### RSpecでの`be_within`マッチャの使用

RSpecを使用している場合、`be_within`マッチャを使って同様の検証が可能です。

```ruby
require 'rails_helper'

RSpec.describe 'TimeComparison' do
  it 'compares times within allowed difference' do
    time1 = Time.now
    time2 = time1 + 5.seconds  # 5秒後

    expect(time2).to be_within(10.seconds).of(time1)
  end
end
```

このテストでは、`time2`が`time1`から**10秒以内**の差であることを検証しています。

---

### 応用例：秒数を無視した時刻の比較

もし秒数以下の精度を無視して、時刻を比較したい場合は、`Time`オブジェクトの`change`メソッドを使って秒数をゼロに設定できます。

```ruby
def test_time_comparison_without_seconds
  time1 = Time.now
  time2 = time1 + 30.seconds  # 30秒後

  time1_rounded = time1.change(sec: 0)
  time2_rounded = time2.change(sec: 0)

  assert_equal time1_rounded, time2_rounded, "時刻（分単位）が一致しません"
end
```

この例では、秒数をゼロに丸めた上で、時刻が一致するかを確認しています。

---

### `assert_operator`を使用した比較

特定の範囲内にあるかを、`assert_operator`で比較演算子を使って検証することもできます。

```ruby
def test_time_difference_within_range
  time1 = Time.now
  time2 = time1 + 5.seconds  # 5秒後

  allowed_difference = 10.seconds

  time_difference = (time1 - time2).abs

  assert_operator time_difference, :<=, allowed_difference, "時刻の差が許容範囲を超えています"
end
```

---

### まとめ

- **`assert_in_delta`**: 値の差が特定の範囲内であることを検証します。
- **`be_within`マッチャ（RSpec）**: RSpecで同様の検証を行うために使用します。
- **秒数の無視**: `change(sec: 0)`で秒数をゼロにして比較します。
- **`assert_operator`**: 演算子を使ってカスタムな比較が可能です。

---

ご不明な点やさらに詳しい説明が必要な場合は、お気軽にお知らせください。