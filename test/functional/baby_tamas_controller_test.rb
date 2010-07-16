require 'test_helper'

class BabyTamasControllerTest < ActionController::TestCase
  test 'index SHOULD redirect to home page' do
    get :index
    assert_redirected_to root_url
  end
end
