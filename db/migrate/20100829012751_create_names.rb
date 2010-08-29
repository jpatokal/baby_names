class CreateNames < ActiveRecord::Migration
  def self.up
    create_table :names do |t|
      t.string :script
      t.string :latin
      t.string :normalized
      t.references :language

      t.timestamps
    end
  end

  def self.down
    drop_table :names
  end
end
