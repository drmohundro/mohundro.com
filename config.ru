require 'toto'

# Rack config
use Rack::Static, :urls => ['/css', '/js', '/images', '/favicon.ico'], :root => 'public'
use Rack::CommonLogger

if ENV['RACK_ENV'] == 'development'
  use Rack::ShowExceptions
end

#
# Create and configure a toto instance
#
toto = Toto::Server.new do
  Toto::Paths[:templates] = 'blog/templates'
  Toto::Paths[:pages] = 'blog/templates/pages'
  Toto::Paths[:articles] = 'blog/articles'

  #
  # Add your settings here
  # set [:setting], [value]
  # 
  set :author,    'David Mohundro'
  set :title,     'From the life of a programmer'
  set :root,      'index'
  set :prefix,    'blog'
  set :date,      lambda {|now| now.strftime("%B #{now.day.ordinal} %Y") }
  set :markdown,  :smart
  set :url,       'http://localhost:9292/blog/'
  # set :disqus,    false                                     # disqus id, or false
  # set :summary,   :max => 150, :delim => /~/                # length of article summary and delimiter
  set :ext,       'mk'                                        # file extension for articles
  # set :cache,      28800                                    # cache duration, in seconds
end

app = Rack::Builder.new do
  use Rack::CommonLogger

  map '/blog' do
    run toto
  end

  map '/' do
    run Proc.new {|env| [200, {"Content-Type" => "text/html"}, ["Hello Rack!"]]}
  end
end

run app
