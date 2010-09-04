module Locale
  module Japanese
    WILDCARD = "[rl]"

    def locale
      Locale::Japanese
    end
    
    def normalize!
      self.normalized = self.latin.gsub(Regexp.new(WILDCARD, Regexp::IGNORECASE), '_') if self.latin
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
