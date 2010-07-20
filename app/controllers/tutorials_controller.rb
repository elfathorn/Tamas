class TutorialsController < ApplicationController
  before_filter :login_required
  before_filter :owner_not_working
  before_filter :redirect_to_tutorial_if_a_tutorial_exists, :only => [ :new ]
  before_filter :redirect_to_owner_if_not_current_owner, :only => [ :show ]
  before_filter :redirect_to_new_tutorial_if_owner_without_tutorial, :only => [ :destroy ]
  before_filter :set_variables_for_new_tutorial, :only => [ :new, :create ]

  def show
  end

  def new
    @error_points_no_display = true
  end
  
  def create
    @tutorial.owner = @current_owner
    valid1 = @baby_tama_1.valid?
    valid2 = @baby_tama_2.valid?
    valid3 = @baby_tama_3.valid?
    if (@points.sum == 0) && valid1 && valid2 && valid3 && @tutorial.save
      flash[:notice] = "Successfully created tutorial."
      update_baby_tama_attributes(1, @baby_tama_1)
      update_baby_tama_attributes(2, @baby_tama_2)
      update_baby_tama_attributes(3, @baby_tama_3)
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
    redirect_by_condition(@current_owner.working?, @current_owner, "You have already done the tutorial.")
  end

  def redirect_to_tutorial_if_a_tutorial_exists
    redirect_by_condition(!@current_owner.tutorial.nil?, @current_owner.tutorial, "You have already started a tutorial.")
  end

  def redirect_to_owner_if_not_current_owner
    tutorial = Tutorial.find(params[:id])
    redirect_by_condition(tutorial.owner != @current_owner, @current_owner, "You can't access to another user tutorial.")
  end

  def redirect_to_new_tutorial_if_owner_without_tutorial
    redirect_by_condition(@current_owner.tutorial.nil?, new_tutorial_path, "You have to finish the tutorial before playing.")
  end

  def set_variables_for_new_tutorial
    @username = current_user.username.capitalize
    @tutorial = params[:tutorial].nil? ? Tutorial.new : Tutorial.new(params[:tutorial])
    @baby_tama_1 = params[:baby_tama_1].nil? ? BabyTama.new(:name => "#{@username} Tama 1") : BabyTama.new(params[:baby_tama_1])
    @baby_tama_2 = params[:baby_tama_2].nil? ? BabyTama.new(:name => "#{@username} Tama 2") : BabyTama.new(params[:baby_tama_2])
    @baby_tama_3 = params[:baby_tama_3].nil? ? BabyTama.new(:name => "#{@username} Tama 3") : BabyTama.new(params[:baby_tama_3])
    @tamas = [ @baby_tama_1, @baby_tama_2, @baby_tama_3 ]
    @points = [ @baby_tama_1.get_leaving_points, @baby_tama_2.get_leaving_points, @baby_tama_3.get_leaving_points ]
  end

  def update_baby_tama_attributes(number, baby_tama)
    original_baby_tama = @tutorial.baby_tamas.find_by_name("#{@username} Tama #{number}")
    original_baby_tama.update_attributes( :name => baby_tama.name, :strength => baby_tama.strength, :intellect => baby_tama.intellect, :fantasy => baby_tama.fantasy )
  end

end
