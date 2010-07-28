class UsersController < ApplicationController
  before_filter :login_required, :only => [ :index ]

  def index
    path = current_user.rookie.nil? ? current_user.owner : current_user.rookie
    redirect_to path
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Thank you for signing up! You are now logged in."
      redirect_to edit_rooky_tutorial_baby_tama_path(current_user.rookie, current_user.rookie.tutorial, current_user.rookie.tutorial.baby_tama)
    else
      render :action => 'new'
    end
  end
end
