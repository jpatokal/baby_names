class Name < ActiveRecord::Base
  belongs_to :language

  def ==(name)
    (permutations & name.permutations).any?
  end

  def normalize!
    self.normalized = latin
    self
  end

  def save
    normalize! unless normalized
  end

  def permutations
    [ normalized ]
  end
end
