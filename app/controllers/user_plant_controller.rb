class UserPlantController < ApplicationController
  # TODO: current_user
  # TODO: new? edit?

  # render JSON of all the current user's plants
  def index
    @user_plants = UserPlant.where(user: current_user)
    render json: @user_plants
  end

  def create
    @user_plant = UserPlant.new(params[:user_plant], user: current_user)
    if @user_plant.save
      redirect_to @user_plant
    else
      # This line overrides the default rendering behavior, which
      # would have been to render the "create" view.
      render "new"
    end
  end

  def show
    user_plant = current_user.plants.find(params[:id])
    render json: user_plant
  end

  # update a plant
  def update
    user_plant = current_user.plants.find(params[:id])
    user_plant.update!(user_plant_params)
    redirect_to user_plant 
  end

  # deletes a user plant
  def destroy
    UserPlant.destroy(params[:id])
  end

  private
  def user_plant_params
    params.require(:user_plant).permit(
      :pot_size, :last_watered, :image, :indoors
    )
  end
end
