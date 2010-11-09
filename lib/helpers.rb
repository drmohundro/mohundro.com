class String
  def camelcase_to_dashes
    val = to_s.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1-\2').
      gsub(/([a-z\d])([A-Z])/,'\1-\2').
      downcase

    singular_compound_words().each do |word|
      val.gsub! word, word.gsub('-', '')
    end

    val.gsub! 'net20', 'net-20'
    val.gsub! 'bindinglist-databinding-the-way-you-would-expect-in-net-20', 'bindinglist---data-binding-the-way-you-would-expect-in-net-20'

    val
  end

  private

  def singular_compound_words
    ['power-shell', 'win-dbg', 'event-setters', 'manual-reset-event', 'tools-install-community-controls',
     'file-helpers', 'ftp-web-request-ftp-web-response', 'win-snap', 'flow-layout-panel', 'outer-html',
     'data-binding', 'managed-spy', 'feed-burner', 'background-worker', 'i-support-initialize', 'ms-build',
     'code-plex', 'x-path', 'binding-list', 'design-mode', 'browsable-attribute', 'one-care']
  end
end
