class UserController < ApplicationController
  before_action :find_user, only: [:index, :show]

  def create
    @user = User.new(user_params)
    if @user.save
      # TODO: redirect to login? log in for them and go to home page?
      redirect_to user
    else
      # This line overrides the default rendering behavior, which
      # would have been to render the "create" view.
      render "new"
    end
  end

  # show one user
  def show
    render json: @user
  end

  # update a user 
  def update
    @user.update!(user_params)
    redirect_to @user
  end

  # deletes a user 
  def destroy
    User.destroy(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(
      :name, :email, :password
    )
  end

  def find_user
    @user = User.find(params[:id])
  end
end
