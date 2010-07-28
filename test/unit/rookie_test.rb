require 'test_helper'

class RookieTest < ActiveSupport::TestCase
  def new_rookie(set_user = true)
    attributes = {}
    attributes[:user] = set_user ? User.first : nil
    rookie = Rookie.new(attributes)
    rookie.valid? # run validations
    rookie
  end

  def setup
    Rookie.delete_all
  end

  test 'new rookie SHOULD BE valid' do
    assert new_rookie.valid?
  end

  test 'new rookie SHOULD REQUIRE an user' do
    assert new_rookie(false).errors.on(:user)
  end

  test 'new rookie SHOULD HAVE a tutorial' do
    Rookie.delete_all
    rookie = new_rookie
    assert_difference 'Tutorial.count' do
      rookie.save!
    end
    assert rookie.tutorial
  end

  test 'destroy rookie SHOULD CREATE an owner' do
    Rookie.delete_all
    rookie = new_rookie
    rookie.save!
    user_id = rookie.user.id
    assert_difference 'Owner.count', 1 do
      Rookie.destroy rookie
    end
    assert User.find(user_id).owner
  end

  test 'destroy rookie SHOULD GIVE a tama to owner' do
    Rookie.delete_all
    rookie = new_rookie
    rookie.save!
    user_id = rookie.user.id
    tutorial = rookie.tutorial
    BabyTama.delete_all
    tama_stubs = BabyTama.create!(:tutorial => tutorial, :name => 'Tama', :strength => 9, :intellect => 5, :fantasy => 4)
    tutorial.stubs(:baby_tama).returns(tama_stubs)
    Rookie.destroy rookie
    owner = User.find(user_id).owner
    assert_equal 1, owner.tamas.length
    tama = owner.tamas.first
    assert_equal 'Tama', tama.name
    assert_equal 9, tama.strength
    assert_equal 5, tama.intellect
    assert_equal 4, tama.fantasy
  end

  test 'destroy rookie SHOULD DESTROY his tutorial' do
    rookie = new_rookie
    rookie.save!
    assert_difference 'Tutorial.count', -1 do
      Rookie.destroy rookie
    end
  end

end
