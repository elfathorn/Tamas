class TutorialsController < ApplicationController
  before_filter :login_required
  before_filter :owner_not_working
  before_filter :redirect_to_owner_if_not_current_owner, :only => [ :show ]
  before_filter :redirect_to_new_tutorial_if_owner_without_tutorial, :only => [ :destroy ]

  def show
  end

  def new
    @tutorial = Tutorial.new
  end
  
  def create
    @tutorial = Tutorial.new(params[:tutorial])
    @tutorial.owner = @current_owner
    if @tutorial.save
      flash[:notice] = "Successfully created tutorial."
      redirect_to @tutorial
    else
      render :action => 'new'
    end
  end

  def destroy
    Tutorial.destroy @current_owner.tutorial
    redirect_to @current_owner
  end

  private

  def owner_not_working
    @current_owner = current_user.owner
    if @current_owner.working?
      flash[:error] = "You have already done the tutorial."
      redirect_to @current_owner
    end
  end

  def redirect_to_owner_if_not_current_owner
    tutorial = Tutorial.find(params[:id])
    if tutorial.owner != @current_owner
      flash[:error] = "You can't access to another user tutorial."
      redirect_to @current_owner
    end
  end

  def redirect_to_new_tutorial_if_owner_without_tutorial
    if @current_owner.tutorial.nil?
      flash[:error] = "You have to finish the tutorial before playing."
      redirect_to new_tutorial_path
    end
  end
end
