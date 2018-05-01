class V1::SensorsController < ApplicationController
  
  # User: Get all sensors with available readings
  # Device: Get all sensors that should be reported
  def index
    if current_user != nil && current_device == nil
      @sensors = current_user.device.sensors
    elsif current_device != nil && current_user == nil
      @sensors = current_device.user.sensors 
    else
      head(:unauthorized)
      return 
    end
    
    render json: @sensors, status: :ok
    return 
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
