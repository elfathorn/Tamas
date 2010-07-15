require 'test_helper'

class TutorialsControllerTest < ActionController::TestCase
  def test_create_invalid
    login_as :foo
    Tutorial.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    login_as :foo
    Tutorial.any_instance.stubs(:valid?).returns(true)
    post :create
    tutorial = assigns['tutorial']
    assert_equal owners(:foo_owner), tutorial.owner
    assert_redirected_to tutorial
  end

  test 'new SHOULD BE redirected if not logged in' do
    get :new
    assert_redirected_to login_path
  end

  test 'new SHOULD BE redirected if owner working' do
    login_as :binch
    get :new
    assert_redirected_to owners(:binch_owner)
  end

  test 'new SHOULD BE available for owner not working' do
    login_as :foo
    get :new
    assert_template 'new'
  end

  test 'show SHOULD BE redirected if not logged in' do
    get :show, :id => Tutorial.first
    assert_redirected_to login_path
  end

  test 'show SHOULD BE redirected if tutorial owner is not current owner' do
    login_as :foo
    get :show, :id => tutorials(:bar_owner_tutorial)
    assert_redirected_to owners(:foo_owner)
  end

  test 'show SHOULD BE available if tutorial owner is current owner' do
    login_as :foo
    get :show, :id => tutorials(:foo_owner_tutorial)
    assert_template 'show'
  end

  test 'show SHOULD HAVE a title and a h1 set to Tutorial explanations' do
    login_as :foo
    get :show, :id => tutorials(:foo_owner_tutorial)
    assert_tag :tag => 'title', :content => 'Tutorial explanations'
    assert_tag :tag => 'h1', :content => 'Tutorial explanations'
  end

  test 'show SHOULD HAVE a link start playing' do
    login_as :foo
    get :show, :id => tutorials(:foo_owner_tutorial)
    assert_tag :tag => 'a', :attributes => { :href => start_playing_path }
  end

  test 'destroy SHOULD BE redirected if not logged in' do
    get :destroy
    assert_redirected_to login_path
  end

  test 'destroy SHOULD BE redirected if owner working' do
    login_as :binch
    get :destroy
    assert_redirected_to owners(:binch_owner)
  end

  test 'destroy SHOULD BE redirected if owner not working but with no tutorial' do
    login_as :plop
    get :destroy
    assert_redirected_to new_tutorial_path
  end

  test 'destroy SHOULD BE redirected if owner not working finishing his tutorial' do
    login_as :bar
    get :destroy
    assert_redirected_to owners(:bar_owner)
  end

  test 'destroy SHOULD delete the current owner tutorial' do
    login_as :bar
    assert_difference 'Tutorial.count', -1 do
      get :destroy
    end
    assert_equal nil, owners(:bar_owner).tutorial
  end
end
