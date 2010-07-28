class RookiesController < ApplicationController
  before_filter :login_required
  before_filter :redirect_if_not_current_rookie, :only => [ :show ]
  before_filter :redirect_if_no_rookie_available_for_current_user, :only => [ :destroy ]
  before_filter :redirect_if_tutorial_not_finished
  
  def show
  end

  def destroy
    Rookie.destroy @rookie
    redirect_to users_path
  end

  private

  def redirect_if_not_current_rookie
    rookie = Rookie.find(params[:id])
    redirect_by_condition(rookie != current_user.rookie, users_path, "You can't access to this page!")
  end

  def redirect_if_no_rookie_available_for_current_user
    redirect_by_condition(current_user.rookie.nil?, users_path, "You have already done the tutorial!")
  end

  def redirect_if_tutorial_not_finished
    @rookie = current_user.rookie
    path = edit_rooky_tutorial_baby_tama_path(@rookie, @rookie.tutorial, @rookie.tutorial.baby_tama)
    redirect_by_condition(!@rookie.tutorial.finished?, path, "You haven't finished your tutorial!")
  end

end
