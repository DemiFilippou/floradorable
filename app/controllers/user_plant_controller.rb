class UserPlantController < ApplicationController
  # TODO: current_user

  # render JSON of all the current user's plants
  def index
    @user_plants = UserPlant.where(user: current_user)
    render json: @user_plants
  end

  def create
    @user_plant = UserPlant.new(params[:user_plant])
    if @user_plant.save
      redirect_to @user_plant
    else
      # This line overrides the default rendering behavior, which
      # would have been to render the "create" view.
      render "new"
    end
  end

  def update
    user_plant = current_user.plants.find(params[:id])
    user_plant.update!(user_plant_params)
    # TODO: in model
    # if you change pot_size --> change water_frequency
    redirect_to user_plant 
  end

  private
  def user_plant_params
    params.require(:user_plant).permit(
      :pot_size, :last_watered, :image, :indoors
    )
  end
end
