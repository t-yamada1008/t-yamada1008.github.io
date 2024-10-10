---
layout: post
title: content-security-policyについて
date: 2024-10-09
categories: [TIL]
tags: [ruby, rails, gpt]
---

## ひとこと
仕事でドハマりしたので。そもそも何かということを聞いた。

## gpt

コンテンツプライバシーポリシーについてご説明します。おそらく「コンテンツセキュリティポリシー（Content Security Policy、CSP）」のことを指していると思われます。CSPは、ウェブアプリケーションがクロスサイトスクリプティング（XSS）やデータインジェクションなどの攻撃から保護するためのセキュリティ機能です。

**RailsでのCSPの扱い**

Rails（特にバージョン6以降）では、デフォルトでCSPが導入されています。`config/initializers/content_security_policy.rb`ファイルでポリシーを設定できます。これにより、アプリケーションが許可するコンテンツのソースを明示的に指定できます。

**よくある問題と対処法**

- **外部リソースのブロック**: 外部のJavaScriptやCSSを利用している場合、CSPによってこれらがブロックされることがあります。ポリシーに該当のドメインを追加することで解決できます。

  ```ruby
  Rails.application.config.content_security_policy do |policy|
    policy.script_src :self, 'https://example.com'
    policy.style_src :self, 'https://example.com'
  end
  ```

- **インラインスクリプトの禁止**: デフォルトではインラインスクリプトが禁止されています。`unsafe-inline`を許可するか、ハッシュやNonceを利用して特定のスクリプトを許可する必要があります。

  ```ruby
  policy.script_src :self, :unsafe_inline
  ```

  ただし、`unsafe-inline`の使用はセキュリティ上のリスクがあるため、可能な限り避けるべきです。
