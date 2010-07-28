class Tutorial < ActiveRecord::Base
  belongs_to :rookie
  has_one :baby_tama

  attr_accessible :rookie, :baby_tama1, :baby_tama2, :baby_tama3

  after_create :create_baby_tamas
  before_destroy :destroy_baby_tamas

  validates_presence_of :rookie

  def finished?
    self.baby_tama.get_leaving_points > 0 ? false : true
  end

  private

  def create_baby_tamas
    username = self.rookie.user.username.capitalize
    BabyTama.create!(:tutorial => self, :name => "#{username} Tama")
  end

  def destroy_baby_tamas
    BabyTama.destroy self.baby_tama
  end

end
