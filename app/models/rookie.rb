class Rookie < ActiveRecord::Base
  belongs_to :user
  has_one :tutorial
  attr_accessible :user

  after_create :create_tutorial
  before_destroy :create_owner_and_destroy_tutorial

  validates_presence_of :user

  private

  def create_tutorial
    self.tutorial = Tutorial.create
  end

  def create_owner_and_destroy_tutorial
    baby_tama = self.tutorial.baby_tama
    Owner.create!(:user => self.user)
    Tama.create!(:owner => self.user.owner ,:name => baby_tama.name, :strength => baby_tama.strength, :intellect => baby_tama.intellect, :fantasy => baby_tama.fantasy)
    Tutorial.destroy self.tutorial
  end

end
