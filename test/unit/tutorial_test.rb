require 'test_helper'

class TutorialTest < ActiveSupport::TestCase
  def new_tutorial(set_owner = true)
    attributes = {}
    attributes[:owner] = set_owner ? Owner.first : nil
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
    assert new_tutorial(false).errors.on(:owner)
  end

  test 'destroy a tutorial SHOULD set to 1 his owner working value' do
    tutorial = new_tutorial
    tutorial.save!
    owner_id = tutorial.owner.id
    Tutorial.destroy tutorial
    assert_equal 1, Owner.find(owner_id).working
  end

  test 'new tutorial SHOULD HAVE three baby tamas' do
    tutorial = new_tutorial
    assert_difference 'BabyTama.count', 3 do
      tutorial.save!
    end
    assert_equal 3, tutorial.baby_tamas.length
    assert BabyTama.find_by_name("Foo Tama 1")
    assert BabyTama.find_by_name("Foo Tama 2")
    assert BabyTama.find_by_name("Foo Tama 3")
  end

end
