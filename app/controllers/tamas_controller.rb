class TamasController < ApplicationController
  def index
    @tamas = Tama.all
  end
  
  def show
    @tama = Tama.find(params[:id])
  end
end
