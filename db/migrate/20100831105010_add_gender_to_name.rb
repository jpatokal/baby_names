class AddGenderToName < ActiveRecord::Migration
  def self.up
    add_column :names, :gender, :char
  end

  def self.down
    remove_column :names, :gender
  end
end
