class OwnersController < ApplicationController
  before_filter :login_required
  before_filter :set_owners
  before_filter :owner_not_working

  def show
    render 'show_my_owner' if @owner === @current_owner
  end

  private

  def owner_not_working
    if @current_owner === @owner && @current_owner.working === 0
      flash[:error] = "You have to do/finish the tutorial before starting to play."
      path = @current_owner.tutorial.nil? ? new_tutorial_path : @current_owner.tutorial
      redirect_to path
    end
  end

  def set_owners
    @owner = Owner.find(params[:id])
    @current_owner = current_user.owner
  end
  
end
