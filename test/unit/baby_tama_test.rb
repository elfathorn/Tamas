require 'test_helper'

class BabyTamaTest < ActiveSupport::TestCase
  def new_baby_tama(attributes = {}, set_tutorial = true)
    attributes[:tutorial] = set_tutorial ? Tutorial.first : nil
    attributes[:name] ||= 'Foo Tama 1'
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

  test 'a baby tama SHOULD HAVE an unique name' do
    new_baby_tama(:name => 'uniquename').save!
    assert new_baby_tama(:name => 'uniquename').errors.on(:name)
  end

  test 'a baby tama SHOULD NOT HAVE odd characters in name' do
    assert new_baby_tama(:name => 'odd^&(@)').errors.on(:name)
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
