require 'test_helper'

class OwnersControllerTest < ActionController::TestCase
  test 'show SHOULD BE redirected if not logged in' do
    get :show, :id => Owner.first
    assert_redirected_to login_path
  end

  test 'show SHOULD HAVE a template for user owner' do
    login_as :foo
    get :show, :id => owners(:foo_owner).id
    assert_template 'show_my_owner.html'
  end

  test 'show SHOULD HAVE a template for owner different of user owner' do
    login_as :foo
    get :show, :id => owners(:bar_owner).id
    assert_template 'show.html'
  end

  test 'show SHOULD HAVE a title and a h1 with My owner value if user owner page' do
    login_as :bar
    get :show, :id => owners(:bar_owner).id
    assert_tag :tag => 'title', :content => 'My owner'
    assert_tag :tag => 'h1', :content => 'My owner'
  end

  test 'show SHOULD HAVE a title and a h1 with Owner of value if not user owner page' do
    login_as :bar
    get :show, :id => owners(:foo_owner).id
    assert_tag :tag => 'title', :content => "Owner of #{users(:foo).username}"
    assert_tag :tag => 'h1', :content => "Owner of #{users(:foo).username}"
  end
end
