require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    User.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    User.any_instance.stubs(:valid?).returns(true)
    User.any_instance.stubs(:username).returns('Plop')
    post :create
    user = assigns['user']
    assert_redirected_to edit_rooky_tutorial_baby_tama_path(user.rookie, user.rookie.tutorial, user.rookie.tutorial.baby_tama)
    assert_equal user.id, session['user_id']
  end

  test 'index SHOULD REDIRECT if not logged in' do
    get :index
    assert_redirected_to login_path
  end

  test 'index SHOULD REDIRECT if rookie' do
    login_as :bar
    get :index
    assert_redirected_to users(:bar).rookie
  end

  test 'index SHOULD REDIRECT if owner' do
    login_as :binch
    get :index
    assert_redirected_to users(:binch).owner
  end

end
