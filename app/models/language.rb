class Language < ActiveRecord::Base
  validates_presence_of :english, :local
  has_many :names

  def after_initialize
    self.local = english unless local
    self.wildcards = false unless wildcards
  end

  def join_condition(language)
    if wildcards
      "n2.normalized LIKE names.normalized"
    else
      if language.wildcards
        "names.normalized LIKE n2.normalized"
      else
        "names.normalized = n2.normalized"
      end
    end
  end

end
