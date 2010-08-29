class Name < ActiveRecord::Base
  belongs_to :language

  def ==(name)
    self.normalized == name.normalized
  end

  def normalize!
    self.normalized = self.latin
    self
  end
end
