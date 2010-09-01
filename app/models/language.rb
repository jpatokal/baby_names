class Language < ActiveRecord::Base
  validates_presence_of :english, :local
  has_many :names

  def locale_names 
    names.map do |name|
      eval("Locale::#{english}Name.from_name(name)")
    end
  end
end
