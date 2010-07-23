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

  test 'destroy a tutorial SHOULD SET to 1 his owner working value' do
    tutorial = new_tutorial
    tutorial.save!
    owner_id = tutorial.owner.id
    assert_difference 'Tutorial.count', -1 do
      Tutorial.destroy tutorial
    end
    assert_equal 1, Owner.find(owner_id).working
  end

  test 'destroy a tutorial SHOULD CREATE 3 tamas for his owner' do
    tutorial = new_tutorial
    tutorial.save!
    BabyTama.delete_all
    BabyTama.create( :tutorial => Tutorial.first, :name => 'First', :strength => 10, :intellect => 4, :fantasy => 4)
    BabyTama.create( :tutorial => Tutorial.first, :name => 'Second', :strength => 6, :intellect => 7, :fantasy => 5)
    BabyTama.create( :tutorial => Tutorial.first, :name => 'Third', :strength => 9, :intellect => 3, :fantasy => 6)
    tutorial.stubs(:baby_tamas).returns(BabyTama.all)
    owner_id = tutorial.owner.id
    assert_difference 'Tama.count', 3 do
      Tutorial.destroy tutorial
    end
    tamas = Owner.find(owner_id).tamas
    assert_equal 3, tamas.length
    tutorial.baby_tamas.each do |baby_tama|
      tama = tamas.find_by_name(baby_tama.name)
      assert_equal baby_tama.strength, tama.strength
      assert_equal baby_tama.intellect, tama.intellect
      assert_equal baby_tama.fantasy, tama.fantasy
    end
  end

end
