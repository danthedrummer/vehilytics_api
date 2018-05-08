class V1::SensorsController < ApplicationController
  
  # Any(with "list" as param): Get all sensors
  # User: Get all sensors with available readings
  # Device: Get all sensors that should be reported
  def index
    if current_user != nil && current_device == nil
      if params.has_key?('user_filter') 
        @sensors = current_user.sensors
      else
        @sensors = {}
        @sensors['sensors'] = current_user.device.sensors
        @sensors['warnings'] = []
        @sensors['errors'] = []
        @sensors['sensors'].each do |sensor|
          if sensor.sensor_description.upper_range == nil || sensor.sensor_description.lower_range == nil
            next
          elsif sensor.sensor_description.upper_range == nil
            analyse_readings_no_upper(sensor)
          elsif sensor.sensor_description.lower_range == nil
            analyse_readings_no_lower(sensor)
          else
            analyse_readings(sensor)
          end
        end
      end
    elsif current_device != nil && current_user == nil
      @sensors = current_device.user.sensors 
    elsif params.has_key?('user_token') || params.has_key?('user_email') || 
            params.has_key?('device_email') || params.has_key?('device_token') 
      head(:unauthorized)
      return
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
      sensor_list = params['sensors'] != nil ? params['sensors'] : []
      new_sensors = []
      sensor_list.each do |sensor_shortname|
        new_sensors << Sensor.find_by_shortname(sensor_shortname)
      end
      current_user.sensors = new_sensors
      head(:created)
    else
      head(400)
    end
  end
  
  private 
  
    def analyse_readings(sensor)
      problem = 0
      sensor.readings.last(50).each do |reading|
        if reading.value.to_f > sensor.sensor_description.upper_range || reading.value.to_f < sensor.sensor_description.lower_range
          problem += 1
        end
        if problem > 10
          @sensors['errors'] << sensor.shortname
          break
        end
      end
      if problem > 0
        @sensors['warnings'] << sensor.shortname
      end
    end
    
    def analyse_readings_no_upper(sensor)
      problem = 0
      sensor.readings.last(50).each do |reading|
        if reading.value.to_f < sensor.sensor_description.lower_range
          problem += 1
        end
        if problem > 10
          @sensors['errors'] << sensor.shortname
          break
        end
      end
      if problem > 0
        @sensors['warnings'] << sensor.shortname
      end
    end
    
    def analyse_readings_no_lower(sensor)
      problem = 0
      sensor.readings.last(50).each do |reading|
        if reading.value.to_f > sensor.sensor_description.upper_range
          problem += 1
        end
        if problem > 10
          @sensors['errors'] << sensor.shortname
          break
        end
      end
      if problem > 0
        @sensors['warnings'] << sensor.shortname
      end
    end
  
end
