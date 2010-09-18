class AddWildcardsToLanguage < ActiveRecord::Migration
  def self.up
    add_column :languages, :wildcards, :boolean
  end

  def self.down
    remove_column :languages, :wildcards
  end
end
