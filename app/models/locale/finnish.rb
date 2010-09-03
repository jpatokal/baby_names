module Locale
  module Finnish
    def normalize!
      self.normalized = self.latin.gsub('j', 'y').gsub('J', 'Y')
      self
    end
  end
end
