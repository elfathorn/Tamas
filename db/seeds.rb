# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
User.delete_all
Owner.delete_all
Tutorial.delete_all
BabyTama.delete_all
Tama.delete_all
User.create([
  { :username => 'user1', :email => 'user1@gmail.com', :password => 'user1' },
  { :username => 'user2', :email => 'user2@gmail.com', :password => 'user2' },
  { :username => 'user3', :email => 'user3@gmail.com', :password => 'user3' },
  { :username => 'binch', :email => 'binch@gmail.com', :password => 'binch' }
])
binch = User.find_by_username('binch')
binch_owner = Owner.find_by_user_id(binch.id)
binch_owner.update_attribute(:working, 1)
Tama.create([
  { :name => 'Binch Tama 1', :strength => 10, :intellect => 4, :fantasy => 4, :owner => binch_owner },
  { :name => 'Binch Tama 2', :strength => 7, :intellect => 6, :fantasy => 5, :owner => binch_owner },
  { :name => 'Binch Tama 3', :strength => 3, :intellect => 7, :fantasy => 8, :owner => binch_owner }
])