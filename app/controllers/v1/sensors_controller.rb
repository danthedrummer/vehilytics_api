class V1::SensorsController < ApplicationController
  
  # User: Get all sensors with available readings
  # Device: Get all sensors that should be reported
  def index
    # @sensors = Sensor.all
    # render json: @sensors, status: :ok
    if current_user != nil
      Sensor.all
    elsif current_device != nil
      
    else
      head(:unauthorized)
    end
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
