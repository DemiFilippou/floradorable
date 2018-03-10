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
    end
  end

  def show
    if @user_plant.user == current_user
      render json: @user_plant,
        include: { plant: { only: [:name, :water, :light_indoors, :light_outdoors] } },
        except: [:updated_at, :created_at, :user_id]
    else
      render json: { :errors => "You are not authorized to view this." }
    end
  end

  # update a plant
  def update
    if @user_plant.user == current_user
      @user_plant.update(user_plant_params)
      show
    else
      render json: { :errors => "You are not authorized to do this." }
    end
  end

  # water a plant
  def water
    @user_plant = UserPlant.find(params[:user_plant_id])
    if @user_plant.user == current_user
      @user_plant.update(last_watered: DateTime.now)
      show
    else
      render json: { :errors => "You are not authorized to do this." }
    end
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
