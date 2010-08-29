module Locale
  class JapaneseName < Name
    belongs_to :language
    
    def ==(name)
      wildcard = "[rl]"
      pattern = self.normalized.gsub('_', wildcard)
      name.normalized =~ Regexp.new(pattern, Regexp::IGNORECASE)
    end
  end
end
