class TamasController < ApplicationController
  before_filter :login_required
  before_filter :redirect_if_not_current_owner
  before_filter :redirect_if_current_owner_not_working
  before_filter :redirect_if_not_current_owner_tama, :only => [ :show ]

  def index
  end
  
  def show
  end

  private

  def redirect_if_not_current_owner_tama
    @tama = Tama.find(params[:id])
    redirect_by_condition(@tama.owner != @current_owner, owner_tamas_path(@current_owner), "You can't access to this page.")
  end

  def redirect_if_current_owner_not_working
    redirect_by_condition(!@current_owner.working?, @current_owner, "You have to do/finish the tutorial before starting to play.")
  end

  def redirect_if_not_current_owner
    @current_owner = current_user.owner
    redirect_by_condition(params[:owner_id].to_i != @current_owner.id, @current_owner, "You can't access to this page.")
  end

end
