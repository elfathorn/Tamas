require 'test_helper'

class PublicControllerTest < ActionController::TestCase  
  test 'index SHOULD BE available' do
    get :index
    assert_response :success
  end

  test 'index SHOULD HAVE a home link' do
    get :index
    assert_tag :tag => 'a', :attributes => { :href => root_url }
  end

  test 'index SHOULD HAVE log in and sign up links if not logged in' do
    get :index
    assert_tag :tag => 'a', :attributes => { :href => signup_path }
    assert_tag :tag => 'a', :attributes => { :href => login_path }
  end

  test 'index SHOULD HAVE log out link if logged in' do
    login_as :foo
    get :index
    assert_tag :tag => 'a', :attributes => { :href => logout_path }
  end

  test 'index SHOULD HAVE my owner link if logged in' do
    login_as :bar
    get :index
    assert_tag :tag => 'a', :attributes => { :href => owner_path(owners(:bar_owner).id) }
  end
end
