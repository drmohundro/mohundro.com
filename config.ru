require 'bundler'

Bundler.require

require 'toto'
require 'rack-rewrite'

$LOAD_PATH.unshift File.dirname(__FILE__) + '/lib'
require 'helpers'
require 'site'

# Rack config
use Rack::Static, urls: ['/css', '/js', '/images', '/favicon.ico', '/robots.txt', '/google2ac14dbe775dc33a.html'], root: 'public'
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

  r301 %r{/blog/CommentView\.aspx\?guid=(.+)}, lambda { |match, rack_env|
    helper = RedirectHelper.new

    guid = match[1]
    helper.find_path_by_guid guid
  }

  r301 %r{blog/default,month,(\d{4})-(\d{2}).aspx}, lambda { |match, rack_env |
    year, month = match[1], match[2]
    "/blog/month?#{year}-#{month}"
  }

  if ENV['RACK_ENV'] == 'production'
    r301 %r{.*}, 'http://mohundro.com$&', if: Proc.new do |rack_env|
      rack_env['SERVER_NAME'] != 'mohundro.com'
    end
  end
end

toto = Toto::Server.new do
  Toto::Paths[:templates] = 'blog/templates'
  Toto::Paths[:pages] = 'blog/templates/pages'
  Toto::Paths[:articles] = 'blog/articles'

  set :author,    'David Mohundro'
  set :title,     'David Mohundro'
  set :root,      'index'
  set :prefix,    'blog'
  set :date,      -> (now) { now.strftime("%B #{now.day.ordinal} %Y") }
  set :markdown,  [ :smart, :fenced_code_blocks ]
  set :url,       'http://mohundro.com/'
  set :disqus,    'mohundro'
  # set :summary,   max: 150, delim: /~/                # length of article summary and delimiter
  set :ext,       'md'
  # set :cache,      28800                                    # cache duration, in seconds
  set :error,     -> (env) { Site.new.not_found }
end

app = Rack::Builder.new do
  use Rack::CommonLogger

  map '/blog' do
    run toto
  end

  map '/' do
    run Site.new
  end
end

run app
