require 'test_helper'

class TamasControllerTest < ActionController::TestCase
  test 'index SHOULD BE redirected if not logged in' do
    get :index, :owner_id => Owner.first.id
    assert_redirected_to login_path
  end

  test 'index SHOULD BE redirected if not current owner' do
    login_as :foo
    get :index, :owner_id => owners(:binch_owner).id
    assert_redirected_to owners(:foo_owner)
  end

  test 'index SHOULD BE redirected if current owner not working' do
    login_as :foo
    get :index, :owner_id => owners(:foo_owner).id
    assert_redirected_to owners(:foo_owner)
  end

  test 'index SHOULD BE available for current owner' do
    login_as :binch
    get :index, :owner_id => owners(:binch_owner).id
    assert_template 'index'
  end

  test 'index SHOULD HAVE h1 and title set to My tamas if current owner' do
    login_as :binch
    get :index, :owner_id => owners(:binch_owner).id
    test_content_h1_and_title 'My tamas'
  end

  test 'index SHOULD HAVE links to tamas' do
    login_as :binch
    binch_owner = owners(:binch_owner)
    Tama.delete_all
    Tama.create([
      { :name => 'Binch Tama 1', :strength => 8, :intellect => 4, :fantasy => 6, :owner => binch_owner },
      { :name => 'Binch Tama 2', :strength => 7, :intellect => 6, :fantasy => 5, :owner => binch_owner },
      { :name => 'Binch Tama 3', :strength => 3, :intellect => 7, :fantasy => 8, :owner => binch_owner },
      { :name => 'Binch Tama 4', :strength => 7, :intellect => 6, :fantasy => 5, :owner => binch_owner },
      { :name => 'Binch Tama 5', :strength => 3, :intellect => 7, :fantasy => 8, :owner => binch_owner }
    ])
    binch_owner.stubs(:tamas).returns(Tama.all)
    get :index, :owner_id => binch_owner.id
    assert_tag :tag => 'ul', :children => { :count => 5, :only => { :tag => 'li', :children => { :count => 1, :only => { :tag => 'a' } } } }
    binch_owner.tamas.each do |tama|
      assert_tag :tag => 'a', :attributes => { :href => owner_tama_path(binch_owner, tama) }
    end
  end

  test 'show SHOULD BE redirected if not logged in' do
    get :show, :owner_id => Owner.first.id, :id => Tama.first.id
    assert_redirected_to login_path
  end

  test 'show SHOULD BE redirected if not current owner' do
    login_as :foo
    get :show, :owner_id => owners(:binch_owner).id, :id => Tama.first.id
    assert_redirected_to owners(:foo_owner)
  end

  test 'show SHOULD BE redirected if current owner not working' do
    login_as :foo
    get :show, :owner_id => owners(:foo_owner).id, :id => Tama.first.id
    assert_redirected_to owners(:foo_owner)
  end

  test 'show SHOULD BE redirected if tama not one of current owner' do
    login_as :binch
    get :show, :owner_id => owners(:binch_owner).id, :id => tamas(:binchou_tama_one).id
    assert_redirected_to owner_tamas_path(owners(:binch_owner))
  end

  test 'show SHOULD BE available for current owner tama' do
    login_as :binch
    get :show, :owner_id => owners(:binch_owner).id, :id => tamas(:binch_tama_one).id
    assert_template 'show'
    assert_equal tamas(:binch_tama_one), assigns['tama']
  end
end
