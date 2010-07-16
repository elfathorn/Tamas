class Tutorial < ActiveRecord::Base
  belongs_to :owner
  has_many :baby_tamas

  attr_accessible :owner, :baby_tamas

  after_create :create_baby_tamas
  before_destroy :make_owner_working

  validates_presence_of :owner

  private

  def make_owner_working
    self.owner.update_attribute( :working, 1 )
  end

  def create_baby_tamas
    3.times do |i|
      self.baby_tamas << BabyTama.create(:name => "#{self.owner.user.username.capitalize} Tama #{i+1}")
    end
  end

end
