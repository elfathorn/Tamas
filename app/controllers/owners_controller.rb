class OwnersController < ApplicationController
  before_filter :login_required

  def show
    @owner = Owner.find(params[:id])
    render 'show_my_owner' if @owner === current_user.owner
  end
  
end
