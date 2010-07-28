class TamasController < ApplicationController
  before_filter :login_required
  before_filter :redirect_if_not_current_owner
  before_filter :redirect_if_not_current_owner_tama, :only => [ :show ]

  def index
  end
  
  def show
  end

  private

  def redirect_if_not_current_owner
    owner = Owner.find(params[:owner_id])
    @owner = current_user.owner
    redirect_by_condition(owner != @owner, users_path, "You can't access to this page.")
  end

  def redirect_if_not_current_owner_tama
    @tama = Tama.find(params[:id])
    redirect_by_condition(@tama.owner != @owner, users_path, "You can't access to this page.")
  end

end
