class Tutorial < ActiveRecord::Base
  belongs_to :owner
  has_many :baby_tamas

  attr_accessible :owner, :baby_tamas

  after_create :create_baby_tamas
  before_destroy :make_owner_working_and_create_tamas

  validates_presence_of :owner

  private

  def make_owner_working_and_create_tamas
    self.owner.update_attribute(:working, 1)
    self.baby_tamas.each do |baby_tama|
      self.owner.tamas << Tama.create(:name => baby_tama.name, :strength => baby_tama.strength, :intellect => baby_tama.intellect, :fantasy => baby_tama.fantasy)
    end
  end

  def create_baby_tamas
    3.times do |i|
      self.baby_tamas << BabyTama.create(:name => "#{self.owner.user.username.capitalize} Tama #{i+1}")
    end
  end

end
