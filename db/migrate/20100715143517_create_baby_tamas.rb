class CreateBabyTamas < ActiveRecord::Migration
  def self.up
    create_table :baby_tamas do |t|
      t.references :tutorial
      t.string :name
      t.integer :strength, :default => 5
      t.integer :intellect, :default => 5
      t.integer :fantasy, :default => 5
      t.timestamps
    end
  end
  
  def self.down
    drop_table :baby_tamas
  end
end
