class PushiesController < ApplicationController
  def create
    @pushy = Pushy.new(pushy_params.merge({user: current_user}))
    if @pushy.save
      render json: @pushy
    else
      render status: :error, json: {
        message: @pushy.errors 
      }.to_json
    end
  end

  private
  def pushy_params
    params.require(:pushy).permit(:token)
  end
end
