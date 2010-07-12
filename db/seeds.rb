# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
User.delete_all
users = User.create([
  { :username => 'user1', :email => 'user1@gmail.com', :password => 'user1' },
  { :username => 'user2', :email => 'user2@gmail.com', :password => 'user2' },
  { :username => 'user3', :email => 'user3@gmail.com', :password => 'user3' }
])