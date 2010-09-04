module Locale
  module Finnish
    def locale
      Locale::Finnish
    end

    def normalize!
      self.normalized = self.latin.gsub('j', 'y').gsub('J', 'Y') if self.latin
      self
    end
  end
end
