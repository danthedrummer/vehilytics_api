class V1::SensorsController < ApplicationController
  
  def index
    @sensors = Sensor.all
    render json: @sensors, status: :ok
  end
  
  def show
    @sensor = Sensor.find(params[:id])
    render json: @sensor, status: :ok
  end
  
end
