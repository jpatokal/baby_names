module Locale
  class FinnishName < Name
    belongs_to :language

    def normalize!
      self.normalized = self.latin.gsub('j', 'y').gsub('J', 'Y')
      self
    end
  end
end
