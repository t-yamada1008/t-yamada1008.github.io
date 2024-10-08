---
layout: post
title: 605. Can Place Flowers
date: 2024-08-23
categories: [LeetCode]
tags: [ruby]
---

4/75。相変わらず問題文の時点で躓く。
そういえば数学の設問も日本語の時点でわからないことがあったなあと。

## 605. Can Place Flowers
- Easy

You have a long flowerbed in which some of the plots are planted, and some are not. However, flowers cannot be planted in adjacent plots.

Given an integer array flowerbed containing 0's and 1's, where 0 means empty and 1 means not empty, and an integer n, return true if n new flowers can be planted in the flowerbed without violating the no-adjacent-flowers rule and false otherwise.

長い花壇があり、その一部には花が植えられており、一部には植えられていません。しかし、隣接する区画には花を植えることができません。

整数配列 flowerbed が与えられ、この配列は 0 と 1 で構成されています。0 は空の区画を、1 は花が植えられている区画を意味します。また、整数 n が与えられます。この n 本の新しい花を、隣接する区画に花を植えないというルールを守りながら花壇に植えることができる場合は true を、できない場合は false を返してください。

## Example 1:
- Input: flowerbed = [1,0,0,0,1], n = 1
- Output: true

## Example 2:
- Input: flowerbed = [1,0,0,0,1], n = 2
- Output: false

## Constraints:
- 1 <= flowerbed.length <= 2 * 104
- flowerbed[i] is 0 or 1.
- There are no two adjacent flowers in flowerbed.
- 0 <= n <= flowerbed.length

## Code

### 自分で書いたコード
今回は時間をかけたが解くことができた。
強引ではあるけれど...。

```ruby
# @param {Integer[]} flowerbed
# @param {Integer} n
# @return {Boolean}
def can_place_flowers(flowerbed, n)
  result = 0
  flowerbed.each_with_index do |f, i|
    if i == 0
      if flowerbed[i] == 0 && flowerbed[i + 1] == 0
        result = result + 1
        flowerbed[i] = 1
      elsif flowerbed.length == 1
        if f == 0
          result = result + 1
          flowerbed[i] = 1
        end
      end
    elsif i == flowerbed.length - 1
      if flowerbed[i] == 0 && flowerbed[i - 1] == 0
        result = result + 1
        flowerbed[i] = 1
      end
    else
      if flowerbed[i] == 0 && flowerbed[i - 1] == 0 && flowerbed[i + 1] ==0
        result = result + 1
        flowerbed[i] = 1
      end
    end
  end

  n <= result ? true : false
end
```

### GitHub Copilotによる解説

以下に、Can Place Flowers問題の効率的な解法を示します。この解法は、花壇を一度だけ走査し、花を植えることができる場所を見つけることで、時間計算量をO(n)に抑えます。

```ruby
# @param {Integer[]} flowerbed
# @param {Integer} n
# @return {Boolean}
def can_place_flowers(flowerbed, n)
  count = 0
  i = 0
  while i < flowerbed.length
    if flowerbed[i] == 0 && (i == 0 || flowerbed[i - 1] == 0) && (i == flowerbed.length - 1 || flowerbed[i + 1] == 0)
      flowerbed[i] = 1
      count += 1
    end
    i += 1
  end
  count >= n
end

# テストケース
puts can_place_flowers([1,0,0,0,1], 1) # => true
puts can_place_flowers([1,0,0,0,1], 2) # => false
```

解法のポイント
1. flowerbed配列を一度だけ走査します。
2. 現在の区画が空であり、前後の区画も空である場合、花を植えることができます。
3. 花を植えた場合、その区画を1に設定し、カウントを増やします。
4. 最後に、植えた花の数がn以上であればtrueを返し、そうでなければfalseを返します。

この方法は、効率的でシンプルな解法です。

### 可読性悪くない？

このコードは効率的でシンプルですが、可読性を向上させるためにいくつかの改善が可能です。以下に、可読性を向上させたバージョンを示します：

```ruby
# @param {Integer[]} flowerbed
# @param {Integer} n
# @return {Boolean}
def can_place_flowers(flowerbed, n)
  count = 0
  i = 0
  length = flowerbed.length

  while i < length
    if flowerbed[i] == 0
      empty_left = (i == 0 || flowerbed[i - 1] == 0)
      empty_right = (i == length - 1 || flowerbed[i + 1] == 0)

      if empty_left && empty_right
        flowerbed[i] = 1
        count += 1
      end
    end

    i += 1
  end

  count >= n
end

# テストケース
puts can_place_flowers([1,0,0,0,1], 1) # => true
puts can_place_flowers([1,0,0,0,1], 2) # => false
```

改善点
1. 変数名の明確化: length変数を導入して、flowerbed.lengthの呼び出しを簡潔にしました。
2. 条件の分割: empty_leftとempty_rightという変数を導入して、条件を分割し、各条件が何をチェックしているのかを明確にしました。
3. コメントの追加: 必要に応じてコメントを追加して、コードの意図を明確にすることができます。

これにより、コードの可読性が向上し、各部分が何をしているのかがより明確になります。