require 'toto'

@config = Toto::Config::Defaults

@config[:ext] = 'md'
Toto::Paths[:articles] = 'blog/articles'

task :default => :new

desc "Create a new article."
task :new do
  title = ask('Title: ')
  slug = title.empty?? nil : title.strip.slugize

  article = {'title' => title, 'date' => Time.now.strftime("%d/%m/%Y")}.to_yaml
  article << "\n"
  article << "Once upon a time...\n\n"

  path = "#{Toto::Paths[:articles]}/#{Time.now.strftime("%Y-%m-%d")}#{'-' + slug if slug}.#{@config[:ext]}"

  unless File.exist? path
    File.open(path, "w") do |file|
      file.write article
    end
    toto "an article was created for you at #{path}."
  else
    toto "I can't create the article, #{path} already exists."
  end
end

desc "Publish my blog."
task :publish do
  toto "publishing your article(s)..."
  `git push heroku master`
end

def toto msg
  puts "\n  toto ~ #{msg}\n\n"
end

def ask message
  print message
  STDIN.gets.chomp
end

desc "Convert old binary links over to s3 binary links"
task :convert_images do
  Dir["blog/**/*.md"].each do |f|
    puts "Converting #{f}"
    original = File.read f

    next if not original =~ /www.mohundro.com/

    # note - this *could* match on more than I want...
    original.gsub! 'http://www.mohundro.com/blog/', 'https://s3.amazonaws.com/mohundro/blog/'
    original.gsub! '/content/binary/', '/'

    File.open(f, 'w') do |out|
      out << original
    end
  end
end
