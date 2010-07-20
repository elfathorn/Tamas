require 'test_helper'

class TamaTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Tama.new.valid?
  end
end
