class Name < ActiveRecord::Base
  belongs_to :language
  validates_presence_of :latin, :normalized, :gender

  def after_initialize
    self.gender = gender ? gender_string_to_code(gender) : 'U'
    if language_id?
      locale = eval("Locale::#{language.english}") rescue nil
      self.extend(locale) if locale
    end
    self.normalize! unless normalized
  end

  def ==(name)
    (permutations & name.permutations).any? and compatible_gender?(name)
  end

  def locale
    nil
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

  def normalize!
    self.normalized = latin
    self
  end

  def validate
    super
    errors.add("gender", "must be one of M, F, U") unless ['M', 'F', 'U'].include? gender
  end

  def permutations
    [ normalized ]
  end

  private

  def gender_string_to_code(string)
    case string.downcase
    when 'f', 'girl', 'female'
      'F'
    when 'm', 'boy', 'male'
      'M'
    when 'u', 'unisex'
      'U'
    else
      raise "Unknown gender #{string.inspect}"
    end
  end
end
