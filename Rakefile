require "rubygems"
require "tmpdir"

require "bundler/setup"
require "jekyll"


class String
  def red;    "\e[1;31m#{self}\e[0m" end
  def blue;   "\e[1;34m#{self}\e[0m" end
  def green;  "\e[0;32m#{self}\e[0m" end
  def yellow; "\e[0;33m#{self}\e[0m" end
  def gray;   "\e[0;37m#{self}\e[0m" end
end


def say_what? message
  print message
  STDIN.gets.chomp
end


def sluggize str
  str.downcase.gsub(/[^a-z0-9]+/, '-').gsub(/^-|-$/, '');
end

def clean
  puts "  Removing build directory:" + "  ./_site".yellow
  FileUtils.rm_rf './_site'
  puts ""
end


def if_exit str
  if str == 'exit' || str == 'quit' || str == 'done'
    puts ""
    puts "   All done!" if str == 'done'
    puts "   See you soon =)"
    puts ""
    exit 1
  end
end


def directory_exists?(directory)
  !File.directory?(directory)
end


desc "Run local server"
task :server do
  clean
  system "bundle exec jekyll serve --incremental"
end


desc "Generate blog files"
task :generate do
  clean
  Jekyll::Site.new(Jekyll.configuration({
    "source"      => ".",
    "destination" => "_site"
  })).process
end


desc "Generate and publish blog to gh-pages"
task :publish => [:generate] do
  Dir.mktmpdir do |tmp|
    cp_r "_site/.", tmp
    Dir.chdir tmp
    system "git init"
    system "git add ."
    message = "Site updated at #{Time.now.utc}"
    system "git commit -a -m #{message.inspect}"
    system "git remote add origin git@github.com:reatlat/blog.git"
    system "git push -f origin master:gh-pages"
    if_exit('done')
  end
end


desc "Create a new post"
task :new do
  puts "  For create a new post enter [Category, Tags, Title]"
  puts "  For quit enter [exit] in anytime."
  puts ""
  category  = say_what?('  Category: ')
  if category.to_s == ''
    puts ""
    puts "  Category can't be empty!".red
    puts ""
    Rake::Task["new"].reenable
    Rake::Task["new"].invoke
  elsif category.to_s == 'dev'
    category = 'development'
  elsif category.to_s == 'gen'
    category = 'general'
  end
  if_exit(category)
  if directory_exists?("_posts/" + category)
    puts ""
    puts "  Can't create new post: "
    puts "    - Path category not exists.".red
    puts ""
    Rake::Task["new"].reenable
    Rake::Task["new"].invoke
  end
  tags      = say_what?('  Tags:     ')
  if_exit(tags)
  title     = say_what?('  Title:    ')
  if_exit(title)
  filename  = "_posts/" + category + "/#{Time.now.strftime('%Y-%m-%d')}-#{sluggize title}.md"

  
  if File.exist? filename
    puts ""
    puts "  Can't create new post: " + filename.yellow
    puts "    - Path already exists.".red
    puts ""
    Rake::Task["action"].reenable
    Rake::Task["action"].invoke
  end

  File.open(filename, "w+") do |post|
    post.puts "---"
    post.puts "layout:       post"
    post.puts "categories:   #{category}"
    post.puts "tags:         [#{tags}]"
    post.puts "title:        #{title}"
    post.puts "feature_img:  null"
    post.puts "sitemap:"
    post.puts "  lastmod:    #{Time.now.strftime('%FT%T')}"
    post.puts "  priority:   0.5"
    post.puts "  changefreq: monthly"
    post.puts "  exclude:    'no'"
    post.puts "---"
    post.puts ""
    post.puts "Once upon a time..."
  end

  puts ""
  puts "  A new post was created for at:"
  puts "    " + filename.green
  if_exit('exit')
  
end


desc "Default task"
task :default do
  puts "                 _   _       _                _    ".yellow
  puts "                | | | |     | |              | |   ".yellow
  puts "  _ __ ___  __ _| |_| | __ _| |_   _ __   ___| |_  ".yellow
  puts " | '__/ _ \\/ _` | __| |/ _` | __| | '_ \\ / _ \\ __| ".yellow
  puts " | | |  __/ (_| | |_| | (_| | |_ _| | | |  __/ |_  ".yellow
  puts " |_|  \\___|\\__,_|\\__|_|\\__,_|\\__(_)_| |_|\\___|\\__| ".yellow
  puts "                                                   ".yellow
  puts " Copyright © 2016 | MIT License                 ".yellow
  puts " Alex Zappa a.k.a. re[at]lat <reatlat@gmail.com>".yellow
  puts " "
  Rake::Task["action"].reenable
  Rake::Task["action"].invoke
end

desc "Action interacive task"
task :action do
  puts " ╔════════════════════════════════════════════════╗".gray
  puts " ║  NOTE:                                         ║".gray
  puts " ╟────────────────────────────────────────────────╢".gray
  puts " ║  NEW  - Create a new post                      ║".gray
  puts " ║  SERV - Run local server                       ║".gray
  puts " ║  PUSH - Generate and publish blog to gh-pages  ║".gray
  puts " ║  EXIT - Quit                                   ║".gray
  puts " ╚════════════════════════════════════════════════╝".gray
  puts " "
  input = say_what?('  What do you want to do?: ')
  if input == 'new' || input == 'create'
    puts ""
    Rake::Task["new"].reenable
    Rake::Task["new"].invoke
  elsif input == 'serv' || input == 'server' || input == 'dev'
    puts ""
    Rake::Task["server"].reenable
    Rake::Task["server"].invoke
  elsif input == 'push' || input == 'publish' || input == 'pub'
    puts ""
    Rake::Task["publish"].reenable
    Rake::Task["publish"].invoke
  elsif input == 'q' || input == 'quit' || input == 'exit'
    if_exit('exit')
  else
    puts ""
    puts "   Command not founded".red
    puts "   So sorry for the confusion".red
    puts "   Try again.".red
    puts ""
    Rake::Task["action"].reenable
    Rake::Task["action"].invoke
  end
end

# ─│┌┐└┘├┤┬┴┼═║╒╓╔╕╖╗╘╙╚╛╜╝╞╟╠╡╢╣╤