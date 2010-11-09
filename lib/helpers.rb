class String
  def camelcase_to_dashes
    self.to_s.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1-\2').
      gsub(/([a-z\d])([A-Z])/,'\1-\2').
      downcase.
      gsub('power-shell', 'powershell').
      gsub('win-dbg', 'windbg').
      gsub('event-setters', 'eventsetters').
      gsub('manual-reset-event', 'manualresetevent')
  end
end