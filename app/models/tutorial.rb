class Tutorial < ActiveRecord::Base
  belongs_to :owner
  attr_accessible :owner

  before_destroy :make_owner_working

  validates_presence_of :owner

  private

  def make_owner_working
    self.owner.update_attribute( :working, 1 )
  end
end
