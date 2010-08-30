module Locale
  class JapaneseName < Name
    belongs_to :language

    WILDCARD = "[rl]"
    
    def normalize!
      self.normalized = self.latin.gsub(Regexp.new(WILDCARD, Regexp::IGNORECASE), '_')
      self
    end

    def permutations
      perms = [ '' ]
      self.normalized.split(//).each do |c|
        if c == '_'
          perms = perms.map {|p| p += 'r' } + perms.map {|p| p += 'l' }
        else
          perms.map! do |p|
            p += c
          end
        end
      end
      perms
    end
  end
end
