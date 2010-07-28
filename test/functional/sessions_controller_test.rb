require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    User.stubs(:authenticate).returns(nil)
    post :create
    assert_template 'new'
    assert_nil session['user_id']
  end
  
  def test_create_valid
    User.stubs(:authenticate).returns(User.find(1))
    post :create
    assert_redirected_to users_path
    assert_equal 1, session['user_id']
  end

  def test_destroy
    post :destroy
    assert_equal nil, session['user_id']
    assert_redirected_to root_url
  end
end
