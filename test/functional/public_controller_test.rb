require 'test_helper'

class PublicControllerTest < ActionController::TestCase
  test "index DOIT être accessible" do
    get :index
    assert_response :success
  end

  test "index DOIT avoir un title et un h1 Accueil" do
    get :index
    assert_tag :tag => "title", :content => "Accueil"
    assert_tag :tag => "h1", :content => "Accueil"
  end
end
