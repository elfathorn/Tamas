require 'test_helper'

class RookiesControllerTest < ActionController::TestCase
  
  test 'show SHOULD BE REDIRECTED if not logged in' do
    get :show, :id => Rookie.first
    assert_redirected_to login_path
  end

  test 'show SHOULD BE REDIRECTED if not current rookie' do
    login_as :binch
    get :show, :id => users(:bar).rookie
    assert_redirected_to users_path
  end

  test 'show SHOULD BE REDIRECTED if tutorial not finished' do
    login_as :bar
    Tutorial.any_instance.stubs(:finished?).returns(false)
    rookie = users(:bar).rookie
    get :show, :id => rookie
    assert_redirected_to edit_rooky_tutorial_baby_tama_path(rookie, rookie.tutorial, rookie.tutorial.baby_tama)
  end

  test 'show SHOULD BE available if tutorial finished' do
    login_as :bar
    Tutorial.any_instance.stubs(:finished?).returns(true)
    get :show, :id => users(:bar).rookie
    assert_template 'show'
    assert_equal users(:bar).rookie, assigns['rookie']
  end

  test 'show SHOULD HAVE a h1 and a title set by default' do
    login_as :bar
    Tutorial.any_instance.stubs(:finished?).returns(true)
    get :show, :id => users(:bar).rookie
    test_content_h1_and_title('My rookie')
  end

  test 'show SHOULD HAVE a start playing link' do
    login_as :bar
    Tutorial.any_instance.stubs(:finished?).returns(true)
    get :show, :id => users(:bar).rookie
    assert_tag :tag => 'a', :attributes => { :href => start_playing_path }
  end

  test 'destroy SHOULD BE REDIRECTED if not logged in' do
    get :destroy
    assert_redirected_to login_path
  end

  test 'destroy SHOULD BE REDIRECTED if current user without rookie' do
    login_as :binch
    get :destroy
    assert_redirected_to users_path
  end

  test 'destroy SHOULD BE REDIRECTED if tutorial not finished' do
    login_as :bar
    Tutorial.any_instance.stubs(:finished?).returns(false)
    rookie = users(:bar).rookie
    get :destroy
    assert_redirected_to edit_rooky_tutorial_baby_tama_path(rookie, rookie.tutorial, rookie.tutorial.baby_tama)
  end

  test 'destroy SHOULD DELETE ROOKIE if tutorial finished' do
    login_as :bar
    Tutorial.any_instance.stubs(:finished?).returns(true)
    user = users(:bar)
    get :destroy
    assert_equal nil, user.rookie
    assert_redirected_to users_path
  end

end
