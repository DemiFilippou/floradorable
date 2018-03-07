class UserPlantsController < ApplicationController
  # TODO: current_user
  # TODO: new? edit?
  before_action :find_user_plant, only: [:update, :show]

  # render JSON of all the current user's plants
  def index
    @user_plants = UserPlant.where(user: current_user)
    render json: @user_plants,
      include: { plant: { only: [:name, :water, :light_indoors, :light_outdoors] } },
      except: [:updated_at, :created_at, :user_id]
  end

  def create
    @user_plant = UserPlant.new(user_plant_params.merge({user: current_user}))
    if @user_plant.save
      show
      #redirect_to @user_plant
    else
      render json: { :errors => @user_plant.errors.full_messages }
    end
  end

  def show
    render json: @user_plant,
      include: { plant: { only: [:name, :water, :light_indoors, :light_outdoors] } },
      except: [:updated_at, :created_at, :user_id]
  end

  # update a plant
  def update
    @user_plant.update!(user_plant_params)
    show
    #redirect_to @user_plant 
  end

  # deletes a user plant
  def destroy
    UserPlant.destroy(params[:id])
  end

  private
  def user_plant_params
    params.require(:user_plant).permit(
      :pot_size, :last_watered, :image, :indoors, :nickname, :plant_id
    )
  end

  def find_user_plant
    @user_plant = UserPlant.find(params[:id])
  end
end
