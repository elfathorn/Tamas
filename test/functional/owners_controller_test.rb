require 'test_helper'

class OwnersControllerTest < ActionController::TestCase
  test 'show SHOULD BE redirected if not logged in' do
    get :show, :id => Owner.first
    assert_redirected_to login_path
  end

  test 'show SHOULD BE REDIRECTED if not current owner' do
    login_as :foo
    get :show, :id => owners(:binch_owner).id
    assert_redirected_to users_path
  end

  test 'show SHOULD BE available if current owner' do
    login_as :binch
    get :show, :id => owners(:binch_owner).id
    assert_template 'show'
    assert_equal owners(:binch_owner), assigns['owner']
  end

  test 'show SHOULD HAVE a title and a h1 if current owner' do
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
