require 'test_helper'

class TutorialTest < ActiveSupport::TestCase
  def new_tutorial(set_rookie = true)
    attributes = {}
    attributes[:rookie] = set_rookie ? Rookie.first : nil
    tutorial = Tutorial.new(attributes)
    tutorial.valid? # run validations
    tutorial
  end

  def setup
    Tutorial.delete_all
  end

  test 'new tutorial SHOULD BE valid' do
    assert new_tutorial.valid?
  end

  test 'new tutorial SHOULD REQUIRE an owner' do
    assert new_tutorial(false).errors.on(:rookie)
  end

  test 'new tutorial SHOULD HAVE a baby tamas' do
    tutorial = new_tutorial
    assert_difference 'BabyTama.count', 1 do
      tutorial.save!
    end
    assert tutorial.baby_tama
  end

  test 'destroy tutorial SHOULD DELETE the baby tamas' do
    tutorial = new_tutorial
    tutorial.save!
    assert_difference 'BabyTama.count', -1 do
      Tutorial.destroy tutorial
    end
  end

  test 'finished? SHOULD RETURN true if no leaving points for his baby tama' do
    tutorial = new_tutorial
    tutorial.save!
    tutorial.baby_tama.stubs(:get_leaving_points).returns(0)
    assert_equal true, tutorial.finished?
  end

  test 'finished? SHOULD RETURN false if leaving points for his baby tama' do
    tutorial = new_tutorial
    tutorial.save!
    tutorial.baby_tama.stubs(:get_leaving_points).returns(1)
    assert_equal false, tutorial.finished?
  end

end
