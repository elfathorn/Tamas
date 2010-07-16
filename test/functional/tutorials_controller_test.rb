require 'test_helper'

class TutorialsControllerTest < ActionController::TestCase
#  def test_create_valid
#    login_as :foo
#    Tutorial.any_instance.stubs(:valid?).returns(true)
#    post :create
#    tutorial = assigns['tutorial']
#    assert_equal owners(:foo_owner), tutorial.owner
#    assert_redirected_to tutorial
#  end

  test 'create SHOULD FAILED if baby tamas not valid' do
    login_as :foo
    BabyTama.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  test 'create SHOULD FAILED if baby tamas are ok but not the tutorial' do
    login_as :foo
    BabyTama.any_instance.stubs(:valid?).returns(true)
    Tutorial.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
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

  test 'new SHOULD BE redirected if owner not working but having one tutorial already' do
    login_as :foo
    get :new
    assert_redirected_to tutorials(:foo_owner_tutorial)
  end

  test 'new SHOULD BE available for owner not working' do
    login_as :plop
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

  test 'destroy SHOULD DELETE the current owner tutorial' do
    login_as :bar
    assert_difference 'Tutorial.count', -1 do
      get :destroy
    end
    assert_equal nil, owners(:bar_owner).tutorial
  end

  test 'new SHOULD INSTANTIATE three baby tamas with default name' do
    login_as :plop
    get :new
    assert_equal assigns['baby_tama_1'].name, "Plop Tama 1"
    assert_equal assigns['baby_tama_2'].name, "Plop Tama 2"
    assert_equal assigns['baby_tama_3'].name, "Plop Tama 3"
  end

  test 'new SHOULD HAVE a form' do
    login_as :plop
    get :new
    3.times do |i|
      x = i+1
      assert_tag :tag => 'input', :attributes => { :id => "baby_tama_#{x}_name", :value => "Plop Tama #{x}" }
      assert_tag :tag => 'h2', :content => "Plop Tama #{x}"
      assert_tag :tag => 'span', :content => "3 points leaving", :attributes => { :id => "baby_tama_#{x}_leaving_points" }
      assert_tag :tag => 'input', :attributes => { :id => "baby_tama_#{x}_strength", :value => '5', :disabled => "disabled" }
      assert_tag :tag => 'input', :attributes => { :id => "baby_tama_#{x}_intellect", :value => '5', :disabled => "disabled" }
      assert_tag :tag => 'input', :attributes => { :id => "baby_tama_#{x}_fantasy", :value => '5', :disabled => "disabled" }
      assert_tag :tag => 'input', :attributes => { :id => "baby_tama_#{x}_strength_minus", :value => '-', :type => "button" }
      assert_tag :tag => 'input', :attributes => { :id => "baby_tama_#{x}_strength_plus", :value => '+', :type => "button" }
      assert_tag :tag => 'input', :attributes => { :id => "baby_tama_#{x}_intellect_minus", :value => '-', :type => "button" }
      assert_tag :tag => 'input', :attributes => { :id => "baby_tama_#{x}_intellect_plus", :value => '+', :type => "button" }
      assert_tag :tag => 'input', :attributes => { :id => "baby_tama_#{x}_fantasy_minus", :value => '-', :type => "button" }
      assert_tag :tag => 'input', :attributes => { :id => "baby_tama_#{x}_fantasy_plus", :value => '+', :type => "button" }
    end
  end

end
