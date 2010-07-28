class OwnersController < ApplicationController
  before_filter :login_required
  before_filter :redirect_if_not_current_owner

  def show
    @owner = current_user.owner
  end

  private

  def redirect_if_not_current_owner
    owner = Owner.find(params[:id])
    redirect_by_condition(owner != current_user.owner, users_path, "You can't access to this page!")
  end
  
end
