class Site
  def call(env)
    path = env['PATH_INFO'].gsub! '/', ''
    status, content = get_status_and_content(path)

    [status, {"Content-Type" => "text/html"}, [content]]
  end

  def not_found
    render(qualify_path '404')
  end

  private

  def get_status_and_content(path)
    path = 'root' if path == ''
    http_return = 200

    full_path = qualify_path path

    if !File.exists? full_path
      http_return = 404
      full_path = qualify_path '404'
    end

    return http_return, render(full_path)
  end

  def header
    render(qualify_path '_header')
  end

  def footer
    render(qualify_path '_footer')
  end

  def render(path)
    ERB.new(File.read(path)).result(binding)
  end

  def qualify_path(path)
    "#{File.dirname(__FILE__)}/../site/#{path}.rhtml"
  end
end
