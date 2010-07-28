class BabyTama < ActiveRecord::Base
  belongs_to :tutorial
  
  attr_accessible :tutorial, :name, :strength, :intellect, :fantasy

  validates_presence_of :name
  validates_numericality_of :strength, :only_integer => true, :greater_than => 2
  validates_numericality_of :intellect, :only_integer => true, :greater_than => 2
  validates_numericality_of :fantasy, :only_integer => true, :greater_than => 2
  validates_format_of :name, :with => /^[-\w\. _@]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or . -_@"

  def validate_on_update
      errors.add(:leaving_points, "- You still have points") if self.get_leaving_points > 0
  end

  def get_leaving_points
    9 - (self.strength - 3) - (self.intellect - 3) - (self.fantasy - 3)
  end

end
