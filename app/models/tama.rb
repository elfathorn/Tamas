class Tama < ActiveRecord::Base
  belongs_to :owner
  attr_accessible :owner, :name, :strength, :intellect, :fantasy

  validates_presence_of :name, :owner
  validates_format_of :name, :with => /^[-\w\. _@]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or . -_@"
  validates_numericality_of :strength, :only_integer => true, :greater_than => 2
  validates_numericality_of :intellect, :only_integer => true, :greater_than => 2
  validates_numericality_of :fantasy, :only_integer => true, :greater_than => 2
end
