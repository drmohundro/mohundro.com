require 'toto'
require 'rack-rewrite'

$LOAD_PATH.unshift File.dirname(__FILE__) + '/lib'
require 'helpers'

# Rack config
use Rack::Static, :urls => ['/css', '/js', '/images', '/favicon.ico'], :root => 'public'
use Rack::CommonLogger

if ENV['RACK_ENV'] == 'development'
  use Rack::ShowExceptions
end

use Rack::Rewrite do
  r301 %r{/blog/
    (\d{4})/  # year
    (\d{2})/  # month
    (\d{2})/  # day
    (\w+?)    # slug
    \.aspx$}x, lambda { |match, rack_env|
      helper = RedirectHelper.new

      year, month, day, slug = match[1], match[2], match[3], helper.convert_legacy_slug(match[4])
      "/blog/#{year}/#{month}/#{day}/#{slug}/"
  }

  r301 %r{/blog/CategoryView,category,(\w+?)\.aspx}, lambda { |match, rack_env|
    category = match[1].downcase
    "/blog/categories?#{category}"
  }

  r301 %r{/blog/(PermaLink|CommentView),guid,(.+?)\.aspx}, lambda { |match, rack_env|
    helper = RedirectHelper.new

    guid = match[2]
    helper.find_path_by_guid guid
  }
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
  set :disqus,    'mohundro'                                  # disqus id, or false
  # set :summary,   :max => 150, :delim => /~/                # length of article summary and delimiter
  set :ext,       'md'                                        # file extension for articles
  # set :cache,      28800                                    # cache duration, in seconds
end

app = Rack::Builder.new do
  use Rack::CommonLogger

  map '/blog' do
    run toto
  end

  map '/' do
    require 'site'
    run Site.new
  end
end

run app
