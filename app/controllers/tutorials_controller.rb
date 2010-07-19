class TutorialsController < ApplicationController
  before_filter :login_required
  before_filter :owner_not_working
  before_filter :redirect_to_tutorial_if_a_tutorial_exists, :only => [ :new ]
  before_filter :redirect_to_owner_if_not_current_owner, :only => [ :show ]
  before_filter :redirect_to_new_tutorial_if_owner_without_tutorial, :only => [ :destroy ]

  def show
  end

  def new
    @username = current_user.username.capitalize
    @tutorial = Tutorial.new
    @baby_tama_1 = BabyTama.new(:name => "#{@username} Tama 1")
    @baby_tama_2 = BabyTama.new(:name => "#{@username} Tama 2")
    @baby_tama_3 = BabyTama.new(:name => "#{@username} Tama 3")
    @tamas = [ @baby_tama_1, @baby_tama_2, @baby_tama_3 ]
  end
  
  def create
    @tutorial = Tutorial.new(params[:tutorial])
    @tutorial.owner = @current_owner
    @baby_tama_1 = BabyTama.new(params[:baby_tama_1])
    @baby_tama_2 = BabyTama.new(params[:baby_tama_2])
    @baby_tama_3 = BabyTama.new(params[:baby_tama_3])
    @tamas = [ @baby_tama_1, @baby_tama_2, @baby_tama_3 ]
    valid1 = @baby_tama_1.valid?
    valid2 = @baby_tama_2.valid?
    valid3 = @baby_tama_3.valid?
    if valid1 && valid2 && valid3 && @tutorial.save
      flash[:notice] = "Successfully created tutorial."
      baby_tama_1 = @tutorial.baby_tamas.find_by_name("#{current_user.username.capitalize} Tama 1")
      baby_tama_1.update_attributes( :name => @baby_tama_1.name, :strength => @baby_tama_1.strength, :intellect => @baby_tama_1.intellect, :fantasy => @baby_tama_1.fantasy )
      baby_tama_2 = @tutorial.baby_tamas.find_by_name("#{current_user.username.capitalize} Tama 2")
      baby_tama_2.update_attributes( :name => @baby_tama_2.name, :strength => @baby_tama_2.strength, :intellect => @baby_tama_2.intellect, :fantasy => @baby_tama_2.fantasy )
      baby_tama_3 = @tutorial.baby_tamas.find_by_name("#{current_user.username.capitalize} Tama 3")
      baby_tama_3.update_attributes( :name => @baby_tama_3.name, :strength => @baby_tama_3.strength, :intellect => @baby_tama_3.intellect, :fantasy => @baby_tama_3.fantasy )
      redirect_to @tutorial
    else
      @tamas_errors = [ @baby_tama_1.errors, @baby_tama_2.errors, @baby_tama_3.errors ]
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

  def redirect_to_tutorial_if_a_tutorial_exists
    if !@current_owner.tutorial.nil?
      flash[:error] = "You have already started a tutorial."
      redirect_to @current_owner.tutorial
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
