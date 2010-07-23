class Owner < ActiveRecord::Base
  belongs_to :user
  has_one :tutorial
  has_many :tamas

  attr_accessible :user, :tutorial, :tamas

  validates_presence_of :user
end
