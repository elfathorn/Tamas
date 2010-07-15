class AddWorkingToOwner < ActiveRecord::Migration
  def self.up
    add_column :owners, :working, :integer, :default => 0
  end

  def self.down
    remove_column :owners, :working
  end
end
