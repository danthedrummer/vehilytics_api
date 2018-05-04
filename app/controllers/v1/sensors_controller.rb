class V1::SensorsController < ApplicationController
  
  # Any(with "list" as param): Get all sensors
  # User: Get all sensors with available readings
  # Device: Get all sensors that should be reported
  def index
    
    if current_user != nil && current_device == nil
      @sensors = current_user.device.sensors
    elsif current_device != nil && current_user == nil
      @sensors = current_device.user.sensors 
    else
      @sensors = Sensor.all
    end
    
    render json: @sensors, status: :ok
    return 
  end
  
  # GET all details for a specific sensor
  # UNUSED
  def show
    if current_user == nil
      head(:unauthorized)
      return
    end
      
    @sensor = Sensor.find(params[:id])
    render json: @sensor, status: :ok
  end
  
  def create
    
    if current_user == nil
      head(:unauthorized)
      return
    end
    
    if params.has_key?('sensors')
      sensor_list = []
      params['sensors'].each do |sensor_shortname|
        sensor_list << Sensor.find_by_shortname(sensor_shortname)
      end
      current_user.sensors = sensor_list
      head(:created)
    else
      head(400)
    end
  end
  
end
