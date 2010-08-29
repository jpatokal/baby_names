class RenameLanguageName < ActiveRecord::Migration
  def self.up
    rename_column :languages, :name, :english
  end

  def self.down
  end
end
