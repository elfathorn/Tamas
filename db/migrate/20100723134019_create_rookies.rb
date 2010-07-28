class CreateRookies < ActiveRecord::Migration
  def self.up
    create_table :rookies do |t|
      t.references :user
      t.timestamps
    end
  end
  
  def self.down
    drop_table :rookies
  end
end
