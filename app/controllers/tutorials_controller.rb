class TutorialsController < ApplicationController
  before_filter :login_required

  def show
    redirect_to users_path
  end
  
end
