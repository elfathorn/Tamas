require 'test_helper'

class TamaTest < ActiveSupport::TestCase
 def new_tama(attributes = {}, set_owner = true)
    attributes[:owner] = set_owner ? Owner.find(3) : nil
    attributes[:name] ||= 'Binch Tama 1'
    attributes[:strength] ||= 5
    attributes[:intellect] ||= 8
    attributes[:fantasy] ||= 5
    tama = Tama.new(attributes)
    tama.valid? # run validations
    tama
  end

  def setup
    Tama.delete_all
  end

  test 'new SHOULD BE valid' do
    assert new_tama.valid?
  end

  test 'new tama SHOULD REQUIRE an owner' do
    assert new_tama({}, false).errors.on(:owner)
  end

  test 'new tama SHOULD REQUIRE a name' do
    assert new_tama(:name => '').errors.on(:name)
  end

  test 'a tama SHOULD HAVE an integer > 2 value for strength' do
    a_tama_should_have_property_as_an_integer_greater_than_two(:strength)
  end

  test 'a tama SHOULD HAVE an integer > 2 value for intellect' do
    a_tama_should_have_property_as_an_integer_greater_than_two(:intellect)
  end

  test 'a tama SHOULD HAVE an integer > 2 value for fantasy' do
    a_tama_should_have_property_as_an_integer_greater_than_two(:fantasy)
  end

  test 'a tama SHOULD NOT HAVE odd characters in name' do
    assert new_tama(:name => 'odd^&(@)').errors.on(:name)
  end

  private

  def a_tama_should_have_property_as_an_integer_greater_than_two(property)
    assert new_tama(property => '').errors.on(property)
    assert new_tama(property => 'qsfsdfsdf').errors.on(property)
    assert new_tama(property => -162).errors.on(property)
    assert new_tama(property => 2).errors.on(property)
    assert new_tama(property => 12.5).errors.on(property)
  end
end
