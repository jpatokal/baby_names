module Locale
  class Name < ::Name
    def self.from_name(name)
      self.create(:script => name[:script], :latin => name[:latin])
    end
  end
end
