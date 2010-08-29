module Locale
  class JapaneseName < Name
    belongs_to :language

    WILDCARD = "[rl]"
    
    def ==(name)
      pattern = self.normalized.gsub('_', WILDCARD)
      name.normalized =~ Regexp.new(pattern, Regexp::IGNORECASE)
    end

    def normalize!
      self.normalized = self.latin.gsub(Regexp.new(WILDCARD, Regexp::IGNORECASE), '_')
      self
    end
  end
end
