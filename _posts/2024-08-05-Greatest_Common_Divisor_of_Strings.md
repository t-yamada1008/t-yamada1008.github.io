---
layout: post
title: Greatest Common Divisor of Strings
date: 2024-08-05
categories: [LeetCode]
tags: [Ruby, LeetCode75]
---

# 1071. Greatest Common Divisor of Strings

## Problem
For two strings s and t, we say "t divides s" if and only if s = t + t + t + ... + t + t (i.e., t is concatenated with itself one or more times).
Given two strings str1 and str2, return the largest string x such that x divides both str1 and str2.

2つの文字列 s と t において、「t は s を割る」とは、s が t を1回以上繰り返してできる文字列である場合を指します。すなわち、s = t + t + t + ... + t + t という形です。

2つの文字列 str1 と str2 が与えられたとき、str1 と str2 の両方を割ることができる最大の文字列 x を返してください。

## Example
### Example 1:
Input: str1 = "ABCABC", str2 = "ABC"
Output: "ABC"

### Example 2:
Input: str1 = "ABABAB", str2 = "ABAB"
Output: "AB"

### Example 3:
Input: str1 = "LEET", str2 = "CODE"
Output: ""

## Constraints:
1 <= str1.length, str2.length <= 1000
str1 and str2 consist of English uppercase letters.

## Code

```ruby
@param {String} str1
@param {String} str2
@return {String}
def gcd_of_strings(str1, str2)
  # もし str1 + str2 が str2 + str1 と等しくない場合、共通のパターンは存在しない
  return "" if str1 + str2 != str2 + str1

  # 文字列の長さの最大公約数を求め、その長さまでの部分文字列を返す
  gcd_length = gcd(str1.length, str2.length)
  str1[0...gcd_length]
end

# 最大公約数を求めるためのヘルパーメソッド
def gcd(a, b)
  b == 0 ? a : gcd(b, a % b)
end
```

## 解説

このコードは、2つの文字列 str1 と str2 の最大公約数（GCD）となる文字列を見つけるためのものです。

1. 文字列の結合チェック:

```ruby
return "" if str1 + str2 != str2 + str1
```

- str1 と str2 を結合した結果が、逆順に結合した結果と異なる場合、共通のパターンは存在しないため、空文字列を返します。
- 例えば、str1 = "ABC" と str2 = "AB" の場合、"ABC" + "AB" = "ABCAB" と "AB" + "ABC" = "ABABC" は異なるため、共通のパターンは存在しません。

2. 最大公約数の計算:

```ruby
gcd_length = gcd(str1.length, str2.length)
```

- str1 と str2 の長さの最大公約数を求めます。
- この最大公約数は、str1 と str2 の最大公約数となる文字列の長さとなります。

3. 最大公約数の文字列の取得:

```ruby
str1[0...gcd_length]
```

- str1 の先頭から最大公約数の長さまでの部分文字列を取得します。

4. 最大公約数の計算:

```ruby
def gcd(a, b)
  b == 0 ? a : gcd(b, a % b)
end
```

- 最大公約数を求めるためのヘルパーメソッドです。
- ユークリッドの互除法を使用して、a と b の最大公約数を再帰的に求めます。
    - ユークリッドの互除法は以下のように動作します：
        - b が 0 であれば、a が最大公約数です。
        - そうでなければ、a を b で割った余り (a % b) と b で再帰的に gcd を計算します。

## 例に対するアプローチ
```ruby
puts gcd_of_strings("ABCABC", "ABC") # => "ABC"
puts gcd_of_strings("ABABAB", "ABAB") # => "AB"
puts gcd_of_strings("LEET", "CODE") # => ""
```

### gcd_of_strings("ABCABC", "ABC") の場合：
1. str1 + str2 = "ABCABCABC" と str2 + str1 = "ABCABCABC" は等しいので、次に進みます。
2. gcd(6, 3) を計算すると、最大公約数は 3 です。
3. str1[0...3] は "ABC" です。

### gcd_of_strings("ABABAB", "ABAB") # => "AB" の場合:
1. str1 = "ABABAB" と str2 = "ABAB" の場合、"ABABAB" + "ABAB" = "ABABABABAB" と "ABAB" + "ABABAB" = "ABABABABAB" は等しいので、次に進みます。
2. str1.length = 6 と str2.length = 4 なので、gcd(6, 4) を計算します。
3. gcd(6, 4) の計算手順は以下の通りです：
   1. a = 6, b = 4
   2. a % b = 6 % 4 = 2
   3. gcd(4, 2) を再帰的に計算
   4. a = 4, b = 2
   5. a % b = 4 % 2 = 0
   6. gcd(2, 0) なので、最大公約数は 2
   7. gcd_length = 2 なので、str1[0...2] は "AB" です。

### gcd_of_strings("LEET", "CODE") の場合：
- str1 + str2 = "LEETCODE" と str2 + str1 = "CODELEET" は異なるので、空文字列を返します。

このようにして、2つの文字列の最大公約数となる文字列を見つけることができます

## GCD（Greatest Common Divisor）とは？
GCD（Greatest Common Divisor）、または最大公約数とは、2つ以上の整数の共通の約数のうち、最も大きな数のことです。
例えば、24と36のGCDは12です。
GCDは数学やプログラミングで広く使われ、以下の方法で計算されます：

### 計算方法

#### ユークリッド互除法とは？
ユークリッド互除法（Euclidean Algorithm）は、2つの整数の最大公約数（GCD）を効率的に求めるアルゴリズムです。
紀元前300年頃に古代ギリシャの数学者ユークリッドによって記述されました。

次のステップで計算します：
1. 2つの数 a と b を用意し、a>b とする。
2. a を b で割り、その余りを r とする。
3. a を b に、b を r に置き換え、余りが0になるまでこの操作を繰り返す。
4. 余りが0になったときの b がGCDです。

例:
1. a=24, b=36
2. 36 mod 24 = 12
3. 24 mod 12 = 0
4. 24 mod 12=0

よって、GCDは12です。

```ruby
def gcd(a, b)
  while b != 0
    a, b = b, a % b
  end
  a
end

# 例: 24と36のGCDを求める
puts gcd(24, 36)  # 出力: 12
```

### 利点と用途
- 数学: 数学の問題解決や整数論で広く使われます。
- 暗号学: 公開鍵暗号アルゴリズム（例えばRSA）において重要です。
- プログラミング: アルゴリズムやデータ構造の設計において、GCDはしばしば基本的なツールとして使われます。

GCDは、数値の共通の約数を見つけるための基本的かつ重要な概念です。

