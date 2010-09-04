class Name < ActiveRecord::Base
  belongs_to :language

  def self.create_with_locale(locale, hash)
    name = Name.create(hash)
    name.extend locale
    name.normalize!
  end

  def after_initialize
    self.gender = 'U' unless gender
  end

  def ==(name)
    (permutations & name.permutations).any? and compatible_gender?(name)
  end

  def male?
    ['M', 'U'].include? gender
  end

  def female?
    ['F', 'U'].include? gender
  end

  def unisex?
    gender == 'U'
  end

  def compatible_gender?(name)
    return true if unisex?
    if male?
      name.male?
    else
      name.female?
    end
  end

  def gender_from_string!(string)
    self.gender =
      case string.downcase
      when "girl" || "female"
        'F'
      when "boy" || "male"
        'M'
      when 'unisex'
        'U'
      else
        raise "Unknown gender"
      end
    self
  end

  def normalize!
    self.normalized = latin
    self
  end

  def validate
    errors.add("gender", "must be one of M, F, U") unless ['M', 'F', 'U'].include? gender
  end

  def save
    normalize! unless normalized
  end

  def permutations
    [ normalized ]
  end
end
