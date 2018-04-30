class V1::SensorsController < ApplicationController
  
  # GET all supported sensors
  def index
    @sensors = Sensor.all
    render json: @sensors, status: :ok
  end
  
  # GET all details for a specific sensor
  def show
    if current_user == nil
      head(:unauthorized)
      return
    end
      
    @sensor = Sensor.find(params[:id])
    render json: @sensor, status: :ok
  end
  
end
