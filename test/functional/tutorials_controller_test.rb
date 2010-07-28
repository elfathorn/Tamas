require 'test_helper'

class TutorialsControllerTest < ActionController::TestCase
  test 'show SHOULD BE REDIRECTED if not logged in' do
    get :show, :rooky_id => Rookie.first, :id => Tutorial.first
    assert_redirected_to login_path
  end

  test 'show SHOULD BE REDIRECTED to user page' do
    login_as :binch
    get :show, :rooky_id => Rookie.first, :id => Tutorial.first
    assert_redirected_to users_path
  end

end
