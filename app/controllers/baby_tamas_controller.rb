class BabyTamasController < ApplicationController
  before_filter :login_required
  before_filter :redirect_if_not_current_rookie
  before_filter :redirect_if_not_current_tutorial
  before_filter :redirect_if_not_current_baby_tama

  def index
  end

  def edit
  end

  def update
    if @baby_tama.update_attributes(params[:baby_tama])
      flash[:notice] = "Successfully updated baby_tama."
      redirect_to @rookie
    else
      render :action => 'edit'
    end
  end

  private

  def redirect_if_not_current_rookie
    @rookie = Rookie.find(params[:rooky_id])
    redirect_by_condition(@rookie != current_user.rookie, users_path, "You can't access to this page.")
  end

  def redirect_if_not_current_tutorial
    @tutorial = Tutorial.find(params[:tutorial_id])
    redirect_by_condition(@tutorial != @rookie.tutorial, @rookie, "You can't access to this page.")
  end

  def redirect_if_not_current_baby_tama
    @baby_tama = BabyTama.find(params[:id])
    redirect_by_condition(@baby_tama != @tutorial.baby_tama, @rookie, "You can't access to this page.")
  end
  
end
