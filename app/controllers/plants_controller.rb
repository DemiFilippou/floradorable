class PlantsController < ApplicationController
  def search
    @plants = Plant.search(params.require(:query))
    render json: @plants,
      only: [:id, :name]
  end
end
