# 今日の日付を取得
today = Time.now.strftime("%Y-%m-%d")

# タイトルを入力
p "Please enter the title of the post"
title = gets.chomp

# タイトルを入力していない場合はエラーを表示
if title.empty?
  puts "Error: Title is empty"
  exit
end

# ファイル名を作成
# ファイルのディレクトリを_postsに変更
file_name = "#{today}-#{title.downcase.gsub(" ", "_").gsub(".", "_")}.md"

# ファイルを作成し、テンプレートを書き込む
# ファイルがすでに存在する場合はエラーを表示
# ファイルが正常に作成された場合は、作成したファイル名を表示
if File.exist?(file_name)
  puts "Error: File already exists"
else
  File.open(file_name, "w") do |file|
    file.puts("---")
    file.puts("layout: post")
    file.puts("title: #{title}")
    file.puts("date: #{today}")
    file.puts("categories: [TIL]")
    file.puts("tags: []")
    file.puts("---")
  end
  puts "Created: #{file_name}"
end
