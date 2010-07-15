require 'test_helper'

class OwnerTest < ActiveSupport::TestCase
  def new_owner(set_user = true)
    attributes = {}
    attributes[:user] = set_user ? User.first : nil
    owner = Owner.new(attributes)
    owner.valid? # run validations
    owner
  end

  def setup
    Owner.delete_all
  end

  test 'new owner SHOULD BE valid' do
    assert new_owner.valid?
  end

  test 'new owner SHOULD REQUIRE an user' do
    assert new_owner(false).errors.on(:user)
  end

  test 'new owner SHOULD HAVE a zero working value' do
    owner = new_owner
    owner.save!
    assert_equal 0, owner.working
  end
end
