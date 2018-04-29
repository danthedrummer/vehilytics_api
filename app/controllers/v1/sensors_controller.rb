class V1::SensorsController < ApplicationController
  
  def index
    @sensors = Sensor.all
    render json: @sensors, status: :ok
  end
  
end
