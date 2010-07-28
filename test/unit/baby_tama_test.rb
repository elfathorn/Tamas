require 'test_helper'

class BabyTamaTest < ActiveSupport::TestCase
  def new_baby_tama(attributes = {}, set_tutorial = true)
    attributes[:tutorial] = set_tutorial ? Tutorial.first : nil
    attributes[:name] ||= 'Bebe Tama'
    attributes[:strength] ||= 5
    attributes[:intellect] ||= 5
    attributes[:fantasy] ||= 5
    baby_tama = BabyTama.new(attributes)
    baby_tama.valid? # run validations
    baby_tama
  end

  def setup
    BabyTama.delete_all
  end

  def test_should_be_valid
    assert new_baby_tama.valid?
  end

  test 'new baby tama SHOULD REQUIRE a name' do
    assert new_baby_tama(:name => '').errors.on(:name)
  end

  test 'a baby tama SHOULD HAVE an integer > 2 value for strength' do
    a_baby_tama_should_have_property_as_an_integer_greater_than_two(:strength)
  end

  test 'a baby tama SHOULD HAVE an integer > 2 value for intellect' do
    a_baby_tama_should_have_property_as_an_integer_greater_than_two(:intellect)
  end

  test 'a baby tama SHOULD HAVE an integer > 2 value for fantasy' do
    a_baby_tama_should_have_property_as_an_integer_greater_than_two(:fantasy)
  end

  test 'a baby tama SHOULD NOT HAVE odd characters in name' do
    assert new_baby_tama(:name => 'odd^&(@)').errors.on(:name)
  end

  test 'get_leaving_points SHOULD RETURN 3 for new default baby tama' do
    baby_tama = new_baby_tama
    baby_tama.save!
    assert_equal 3, baby_tama.get_leaving_points
  end

  test 'get_leaving_points SHOULD RETURN leaving points for baby tama' do
    baby_tama = new_baby_tama(:name => 'plopi', :strength => 3, :intellect => 3, :fantasy => 3)
    baby_tama.save!
    assert_equal 9, baby_tama.get_leaving_points
    baby_tama2 = new_baby_tama(:name => 'plopi2', :strength => 6, :intellect => 7, :fantasy => 5)
    baby_tama2.save!
    assert_equal 0, baby_tama2.get_leaving_points
    baby_tama3 = new_baby_tama(:name => 'plopi3', :strength => 4, :intellect => 7, :fantasy => 5)
    baby_tama3.save!
    assert_equal 2, baby_tama3.get_leaving_points
  end

  test 'update a baby tama SHOULD NOT HAVE leaving points' do
    baby_tama = new_baby_tama
    baby_tama.save!
    baby_tama.update_attributes({:strength => 6, :fantasy => 4})
    assert baby_tama.errors.on(:leaving_points)
    assert_equal 5, BabyTama.find(baby_tama.id).strength
    assert_equal 5, BabyTama.find(baby_tama.id).fantasy
  end

  test 'update a baby tama SHOULD PASS if no leaving points' do
    baby_tama = new_baby_tama
    baby_tama.save!
    baby_tama.update_attributes({:strength => 6, :fantasy => 4, :intellect => 8})
    assert_equal 6, BabyTama.find(baby_tama.id).strength
    assert_equal 4, BabyTama.find(baby_tama.id).fantasy
    assert_equal 8, BabyTama.find(baby_tama.id).intellect
  end

  private

  def a_baby_tama_should_have_property_as_an_integer_greater_than_two(property)
    assert new_baby_tama(property => '').errors.on(property)
    assert new_baby_tama(property => 'qsfsdfsdf').errors.on(property)
    assert new_baby_tama(property => -162).errors.on(property)
    assert new_baby_tama(property => 2).errors.on(property)
    assert new_baby_tama(property => 12.5).errors.on(property)
  end
end
