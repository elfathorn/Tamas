class CreateTamas < ActiveRecord::Migration
  def self.up
    create_table :tamas do |t|
      t.references :owner
      t.string :name
      t.integer :strength
      t.integer :intellect
      t.integer :fantasy
      t.timestamps
    end
  end
  
  def self.down
    drop_table :tamas
  end
end
