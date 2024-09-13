---
layout: post
title: psqlとrails consoleで乖離がおきた
date: 2024-09-09
categories: [TIL]
tags: []
---

rails consoleでsaveするのを忘れたのか、なぜかpostgresqlとrails console上での乖離がおきた。

コレに対して、psqlで叩いて確認をしたので、その内容を聞いてみた。

## ActiveRecordとpsqlの叩き直し
RailsでActiveRecordのメソッドを使用してデータベースを操作する際に生成されるSQLと、それを直接`psql`で叩いて同じ操作を行う方法について、例を挙げて説明します。

### 例: ユーザーを検索する場合

#### 1. Rails ConsoleでのActiveRecordの使用

まず、RailsコンソールでActiveRecordのクエリを使ってユーザーを検索する例です。

```ruby
# Rails consoleでの例
user = User.find_by(email: 'alice@example.com')
```

このコードを実行すると、Railsは次のようなSQLクエリをデータベースに送信します。

```sql
SELECT "users".* FROM "users" WHERE "users"."email" = 'alice@example.com' LIMIT 1;
```

#### 2. psqlで同じクエリを実行

`psql`クライアントを使用して、上記のSQLクエリをデータベースに直接発行するには、次のようにします。

```bash
psql -U <username> -d <database_name>
```

上記のコマンドで`psql`に接続した後、SQLクエリを実行します：

```sql
SELECT * FROM users WHERE email = 'alice@example.com' LIMIT 1;
```

### 例: ユーザーの更新

#### 1. Rails ConsoleでのActiveRecordの使用

次に、RailsコンソールでActiveRecordを使ってユーザーの情報を更新する例です。

```ruby
# Rails consoleでの例
user = User.find_by(email: 'alice@example.com')
user.update(name: 'Alice Smith')
```

このコードを実行すると、Railsは次のようなSQLクエリをデータベースに送信します。

```sql
UPDATE "users" SET "name" = 'Alice Smith', "updated_at" = '2024-09-09 12:00:00' WHERE "users"."id" = 1;
```

#### 2. psqlで同じクエリを実行

`psql`クライアントで同じ更新操作を行う場合は、以下のようにします：

```sql
UPDATE users SET name = 'Alice Smith', updated_at = '2024-09-09 12:00:00' WHERE email = 'alice@example.com';
```

### まとめ

RailsコンソールでActiveRecordメソッドを呼び出すと、内部で生成されるSQLをログで確認し、それを基に`psql`で直接SQLを実行することが可能です。
この方法で、SQLの学習やデバッグを行うことができます。

Railsのログは通常、`log/development.log`に出力されるので、必要に応じてログを参照してSQLを確認できます。
