class Owner < ActiveRecord::Base
  belongs_to :user
  has_one :tutorial

  attr_accessible :user, :tutorial

  validates_presence_of :user
end
