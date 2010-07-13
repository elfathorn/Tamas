class Owner < ActiveRecord::Base
  belongs_to :user
  attr_accessible :user

  validates_presence_of :user
end
