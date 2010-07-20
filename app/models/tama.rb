class Tama < ActiveRecord::Base
  belongs_to :owner
  attr_accessible :owner, :name, :strength, :intellect, :fantasy
end
