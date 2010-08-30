class Name < ActiveRecord::Base
  belongs_to :language

  def ==(name)
    (permutations & name.permutations).any?
  end

  def normalize!
    self.normalized = self.latin
    self
  end

  def save
    self.normalize! unless self.normalized
  end

  def permutations
    [ self.normalized ]
  end
end
