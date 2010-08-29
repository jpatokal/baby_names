class Language < ActiveRecord::Base
  validates_presence_of :english, :local
  has_many :names
end
