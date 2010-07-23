require 'test_helper'

class OwnersControllerTest < ActionController::TestCase
  test 'show SHOULD BE redirected if not logged in' do
    get :show, :id => Owner.first
    assert_redirected_to login_path
  end

  test 'show SHOULD HAVE a template if not current owner' do
    login_as :foo
    get :show, :id => owners(:bar_owner).id
    assert_template 'show.html'
  end

  test 'show SHOULD HAVE a title and a h1 with Owner of value if not current owner' do
    login_as :bar
    get :show, :id => owners(:foo_owner).id
    test_content_h1_and_title "Owner of #{users(:foo).username}"
  end

  test 'show SHOULD BE redirected to new tutorial path if current user owner not working and has no tutorial' do
    login_as :plop
    get :show, :id => owners(:plop_owner).id
    assert_redirected_to new_tutorial_path
  end

  test 'show SHOULD BE redirected to tutorial if current user owner not working and has a tutorial' do
    login_as :bar
    get :show, :id => owners(:bar_owner).id
    assert_redirected_to tutorials(:bar_owner_tutorial)
  end

  test 'show SHOULD BE available if current user owner working' do
    login_as :binch
    get :show, :id => owners(:binch_owner).id
    assert_template 'show_my_owner.html'
  end

  test 'show SHOULD HAVE a title and a h1 with My owner value if user owner page' do
    login_as :binch
    get :show, :id => owners(:binch_owner).id
    test_content_h1_and_title 'My owner'
  end

  test 'show SHOULD HAVE a My tamas link' do
    login_as :binch
    get :show, :id => owners(:binch_owner).id
    assert_tag :tag => 'a', :attributes => { :href => owner_tamas_path(owners(:binch_owner).id) }
  end
end
