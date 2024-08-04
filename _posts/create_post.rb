# 今日の日付を取得
today = Time.now.strftime("%Y-%m-%d")

# 引数を取得し、ファイル名を作成
# 引数がない場合はUsageを表示
if ARGV.length != 1
  puts "Usage: ruby create_post.rb [Post Title]"
  exit
else
  title = ARGV[0]
end

# ファイル名を作成
# 例: 2020-01-01-Hello-World.md
file_name = "#{today}-#{title.gsub(" ", "_")}.md"

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
