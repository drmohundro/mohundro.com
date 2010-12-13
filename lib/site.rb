class Site
  def call(env)
    path = env['PATH_INFO'].gsub! '/', ''
    http_return, content = render_path(path)

    [http_return, {"Content-Type" => "text/html"}, [content]]
  end

  private

  def render_path(path)
    path = 'root' if path == ''
    http_return = 200

    full_path = qualify_path path

    if !File.exists? full_path
      http_return = 404
      full_path = qualify_path '404'
    end

    return http_return, ERB.new(File.read(full_path)).result(binding)
  end

  def header
    ERB.new(File.read(qualify_path '_header')).result(binding)
  end

  def qualify_path(path)
    "#{File.dirname(__FILE__)}/../site/#{path}.rhtml"
  end
end
