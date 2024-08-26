---
layout: post
title: 345. Reverse Vowels of a String
date: 2024-08-25
categories: [LeetCode]
tags: [ruby]
---

LeetCode 4/75。
popとかこうやって使うんだな。

## 345. Reverse Vowels of a String

Given a string s, reverse only all the vowels in the string and return it.
The vowels are 'a', 'e', 'i', 'o', and 'u', and they can appear in both lower and upper cases, more than once.

この問題では、文字列 s の中で、母音（'a', 'e', 'i', 'o', 'u'、およびそれらの大文字）だけを反転させ、その結果を返す必要があります。以下の手順で解決できます。

## Example 1:
- Input: s = "hello"
- Output: "holle"

## Example 2:
- Input: s = "leetcode"
- Output: "leotcede"

## Constraints:
- 1 <= s.length <= 3 * 105
- s consist of printable ASCII characters.

```ruby
# @param {String} s
# @return {String}
def reverse_vowels(s)
  vowels = s.scan(/[aeiou]/i)
  s.gsub(/[aeiou]/i) { vowels.pop }
end

# testcaseを作成
testcases = [
  {actual: "hello", expected: "holle"},
  {actual: "leetcode", expected: "leotcede"},
  {actual: "aA", expected: "Aa"},
]

# assertメソッドの定義
def assert(actual, expected)
  if actual == expected
    puts "Test passed"
  else
    puts "Test failed: expected #{expected}, got #{actual}"
  end
end

# テストケースを実行
testcases.each do |testcase|
  assert(reverse_vowels(testcase[:actual]), testcase[:expected])
end
```

## 解説
以下に、`reverse_vowels`メソッドの解説を示します。

### 問題の概要
与えられた文字列 `s` の中で、母音（'a', 'e', 'i', 'o', 'u'）のみを逆順にして返す関数を実装します。母音は大文字小文字を区別せずに扱います。

### コードの解説

```ruby
# @param {String} s
# @return {String}
def reverse_vowels(s)
  # 文字列から母音をすべて抽出し、配列に格納します。
  vowels = s.scan(/[aeiou]/i)

  # 文字列の母音を逆順に置き換えます。
  s.gsub(/[aeiou]/i) { vowels.pop }
end
```

#### 詳細な説明
1. **母音の抽出**:
   ```ruby
   vowels = s.scan(/[aeiou]/i)
   ```
   - `s.scan(/[aeiou]/i)` は正規表現を使って、文字列 `s` からすべての母音を抽出し、配列 `vowels` に格納します。
   - `/[aeiou]/i` は正規表現で、`i` フラグを使うことで大文字小文字を区別せずに母音をマッチさせます。

2. **母音の置き換え**:
   ```ruby
   s.gsub(/[aeiou]/i) { vowels.pop }
   ```
   - `s.gsub(/[aeiou]/i)` は正規表現を使って、文字列 `s` の中のすべての母音を置き換えます。
   - ブロック `{ vowels.pop }` は、`vowels` 配列の最後の要素を取り出して置き換えます。これにより、母音が逆順に置き換えられます。

### テストケースの作成
以下にテストケースを追加します：

```ruby
# テストケースを作成
testcases = [
  {actual: reverse_vowels("hello"), expected: "holle"},
  {actual: reverse_vowels("leetcode"), expected: "leotcede"},
  {actual: reverse_vowels("aA"), expected: "Aa"}
]

# assertメソッドの定義
def assert(actual, expected)
  if actual == expected
    puts "Test passed"
  else
    puts "Test failed: expected #{expected}, got #{actual}"
  end
end

# テストケースの実行
testcases.each do |testcase|
  assert(testcase[:actual], testcase[:expected])
end
```

### テストケースの説明
1. **"hello"**:
   - 入力: `"hello"`
   - 出力: `"holle"`
   - 母音 'e' と 'o' が逆順に置き換えられます。

2. **"leetcode"**:
   - 入力: `"leetcode"`
   - 出力: `"leotcede"`
   - 母音 'e', 'e', 'o', 'e' が逆順に置き換えられます。

3. **"aA"**:
   - 入力: `"aA"`
   - 出力: `"Aa"`
   - 母音 'a' と 'A' が逆順に置き換えられます。

このようにして、`reverse_vowels`メソッドは与えられた文字列の母音を逆順に置き換えることができます。

## scan と gsub のブロックの使い方

### scan メソッド
scan メソッドは、文字列から正規表現にマッチする部分をすべて抽出し、配列として返します。
ブロックを使うことで、マッチした各部分に対して処理を行うこともできます。

- s.scan(/[aeiou]/i) は、文字列 s からすべての母音を抽出し、配列 vowels に格納します。
- 正規表現 /[aeiou]/i は、母音（a, e, i, o, u）にマッチし、大文字小文字を区別しません（i フラグ）。

### gsub メソッド
gsub メソッドは、文字列の中で正規表現にマッチする部分を置き換えます。ブロックを使うことで、マッチした各部分に対して動的に置き換えを行うことができます。

- s.gsub(/[aeiou]/i) は、文字列 s の中のすべての母音を置き換えます。
- ブロック { vowels.pop } は、vowels 配列の最後の要素を取り出して置き換えます。これにより、母音が逆順に置き換えられます。
具体例

以下に具体的な例を示します：

1. reverse_vowels("hello") の場合：
- scan メソッドで ["e", "o"] が抽出されます。
- gsub メソッドで ["o", "e"] が順に置き換えられ、結果は "holle" になります。

2. reverse_vowels("leetcode") の場合：
- scan メソッドで ["e", "e", "o", "e"] が抽出されます。
- gsub メソッドで ["e", "o", "e", "e"] が順に置き換えられ、結果は "leotcede" になります。

3. reverse_vowels("aA") の場合：
- scan メソッドで ["a", "A"] が抽出されます。
- gsub メソッドで ["A", "a"] が順に置き換えられ、結果は "Aa" になります。

このように、scan と gsub をブロックで使うことで、文字列の特定の部分を抽出し、動的に置き換えることができます。
