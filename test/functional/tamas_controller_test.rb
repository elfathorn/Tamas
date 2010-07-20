require 'test_helper'

class TamasControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Tama.first
    assert_template 'show'
  end
end
