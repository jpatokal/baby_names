class Name < ActiveRecord::Base
  belongs_to :language

  def ==(name)
    self.normalized == name.normalized
  end
end
