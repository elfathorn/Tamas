require 'test_helper'

class BabyTamasControllerTest < ActionController::TestCase

  test 'edit SHOULD BE REDIRECTED if not logged in' do
    get :edit, :rooky_id => Rookie.first, :tutorial_id => Tutorial.first, :id => BabyTama.first
    assert_redirected_to login_path
  end

  test 'edit SHOULD BE REDIRECTED if not current rookie' do
    login_as :bar
    get :edit, :rooky_id => users(:foo).rookie, :tutorial_id => Tutorial.first, :id => BabyTama.first
    assert_redirected_to users_path
  end

  test 'edit SHOULD BE REDIRECTED if not current tutorial' do
    login_as :bar
    get :edit, :rooky_id => users(:bar).rookie, :tutorial_id => tutorials(:foo_rookie_tutorial), :id => BabyTama.first
    assert_redirected_to users(:bar).rookie
    assert_equal users(:bar).rookie, assigns['rookie']
  end

  test 'edit SHOULD BE REDIRECTED if not current baby tama' do
    login_as :bar
    get :edit, :rooky_id => users(:bar).rookie, :tutorial_id => tutorials(:bar_rookie_tutorial), :id => baby_tamas(:foo_baby_tama)
    assert_redirected_to users(:bar).rookie
    assert_equal users(:bar).rookie.tutorial, assigns['tutorial']
  end

  test 'edit SHOULD BE available' do
    login_as :bar
    get :edit, :rooky_id => users(:bar).rookie, :tutorial_id => tutorials(:bar_rookie_tutorial), :id => baby_tamas(:bar_baby_tama)
    assert_template 'edit'
    assert_equal baby_tamas(:bar_baby_tama), assigns['baby_tama']
  end

  test 'edit SHOULD HAVE a form' do
    login_as :bar
    get :edit, :rooky_id => users(:bar).rookie, :tutorial_id => tutorials(:bar_rookie_tutorial), :id => baby_tamas(:bar_baby_tama)
    test_content_h1_and_title('Edit your baby tama')
    assert_tag :tag => 'input', :attributes => { :id => "baby_tama_name", :value => "Bar Baby Tama" }
    assert_tag :tag => 'h2', :content => 'My first tama'
    assert_tag :tag => 'span', :content => "3", :attributes => { :id => "baby_tama_leaving_points" }
    assert_tag :tag => 'input', :attributes => { :id => "baby_tama_strength", :value => '5' }
    assert_tag :tag => 'input', :attributes => { :id => "baby_tama_intellect", :value => '5' }
    assert_tag :tag => 'input', :attributes => { :id => "baby_tama_fantasy", :value => '5' }
    assert_tag :tag => 'input', :attributes => { :id => "baby_tama_strength_minus", :value => '-', :type => "button", :onclick => "substract_attribute('strength');" }
    assert_tag :tag => 'input', :attributes => { :id => "baby_tama_strength_plus", :value => '+', :type => "button", :onclick => "add_attribute('strength');" }
    assert_tag :tag => 'input', :attributes => { :id => "baby_tama_intellect_minus", :value => '-', :type => "button", :onclick => "substract_attribute('intellect');" }
    assert_tag :tag => 'input', :attributes => { :id => "baby_tama_intellect_plus", :value => '+', :type => "button", :onclick => "add_attribute('intellect');" }
    assert_tag :tag => 'input', :attributes => { :id => "baby_tama_fantasy_minus", :value => '-', :type => "button", :onclick => "substract_attribute('fantasy');" }
    assert_tag :tag => 'input', :attributes => { :id => "baby_tama_fantasy_plus", :value => '+', :type => "button", :onclick => "add_attribute('fantasy');" }
  end

  test 'update SHOULD BE REDIRECTED if not logged in' do
    post :update, :rooky_id => Rookie.first, :tutorial_id => Tutorial.first, :id => BabyTama.first
    assert_redirected_to login_path
  end

  test 'update SHOULD BE REDIRECTED if not current rookie' do
    login_as :bar
    post :update, :rooky_id => users(:foo).rookie, :tutorial_id => Tutorial.first, :id => BabyTama.first
    assert_redirected_to users_path
  end

  test 'update SHOULD BE REDIRECTED if not current tutorial' do
    login_as :bar
    post :update, :rooky_id => users(:bar).rookie, :tutorial_id => tutorials(:foo_rookie_tutorial), :id => BabyTama.first
    assert_redirected_to users(:bar).rookie
    assert_equal users(:bar).rookie, assigns['rookie']
  end

  test 'update SHOULD BE REDIRECTED if not current baby tama' do
    login_as :bar
    post :update, :rooky_id => users(:bar).rookie, :tutorial_id => tutorials(:bar_rookie_tutorial), :id => baby_tamas(:foo_baby_tama)
    assert_redirected_to users(:bar).rookie
    assert_equal users(:bar).rookie.tutorial, assigns['tutorial']
  end

  test 'update SHOULD BE available' do
    login_as :bar
    post :update, :rooky_id => users(:bar).rookie, :tutorial_id => tutorials(:bar_rookie_tutorial), :id => baby_tamas(:bar_baby_tama)
    assert_equal BabyTama.find(baby_tamas(:bar_baby_tama).id), assigns['baby_tama']
  end

  test 'update IS invalid' do
    BabyTama.any_instance.stubs(:valid?).returns(false)
    login_as :bar
    post :update, :rooky_id => users(:bar).rookie, :tutorial_id => tutorials(:bar_rookie_tutorial), :id => baby_tamas(:bar_baby_tama)
    assert_template 'edit'
  end

  test 'update IS valid' do
    BabyTama.any_instance.stubs(:valid?).returns(true)
    login_as :bar
    post :update, :rooky_id => users(:bar).rookie, :tutorial_id => tutorials(:bar_rookie_tutorial), :id => baby_tamas(:bar_baby_tama),
                      :baby_tama => { :strength => 8, :intellect => 6, :fantasy => 4 }
    assert_redirected_to users(:bar).rookie
    assert_equal 8, BabyTama.find(baby_tamas(:bar_baby_tama).id).strength
    assert_equal 6, BabyTama.find(baby_tamas(:bar_baby_tama).id).intellect
    assert_equal 4, BabyTama.find(baby_tamas(:bar_baby_tama).id).fantasy
  end

end
