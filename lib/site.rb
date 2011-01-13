class Site
  def call(env)
    path = env['PATH_INFO'].gsub! '/', ''
    status, content = get_status_and_content(path)

    [status, {"Content-Type" => "text/html"}, [content]]
  end

  def not_found
    render(qualify_path '404')
  end

  def obscure_email(email)
    return nil if email.nil? #Don't bother if the parameter is nil.
    lower = ('a'..'z').to_a
    upper = ('A'..'Z').to_a
    email.split('').map { |char|
      output = lower.index(char) + 97 if lower.include?(char)
      output = upper.index(char) + 65 if upper.include?(char)
      output ? "&##{output};" : (char == '@' ? '&#0064;' : char)
    }.join
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
  
  def render(path)
    content = to_html(path)
    to_html("#{File.dirname(__FILE__)}/../blog/templates/layout.rhtml", &Proc.new { content })
  end

  def to_html(path, &blk)
    ERB.new(File.read(path)).result(binding)
  end

  def qualify_path(path)
    "#{File.dirname(__FILE__)}/../site/#{path}.rhtml"
  end
end
