class Language < ActiveRecord::Base
  validates_presence_of :english, :local
  has_many :names

  def after_initialize
    self.local = english unless local
  end

end
