class Language < ActiveRecord::Base
  validates_presence_of :english, :local
  has_many :names

  def locale_names
    locale = eval("Locale::#{english}") rescue nil
    return names unless locale
    names.map do |name|
      name.extend(locale).normalize!
    end
  end
end
