class V1::ReportsController < ApplicationController
  
  # Create a new report w/ readings for a given device
  # Intended for the diagnostic reader to use
  def create 
    
    if current_device == nil || current_device.user == nil
      head(:unauthorized)
      return 
    end
    
    if !params.has_key?('time_reported') || !params.has_key?('device_name') || !params.has_key?('readings')
      head(400)
      return
    end
    
    params['readings'].each do |reading|
      if !reading.has_key?('shortname') || !reading.has_key?('value')
        head(400)
        return
      end
    end
    
    @report = Report.new(report_params)
    @report.device = current_device
    @report.save
    
    current_device.reports << @report
    
    problem_sensors = []
    reading_params[:readings].each do |reading|
      r = Reading.new
      r.value = reading[:value]
      r.sensor = Sensor.find_by_shortname(reading[:shortname])
      attach_sensor_to_device(r.sensor, current_device)
      r.report = @report
      r.save
      
      upper_range = r.sensor.sensor_description.upper_range
      lower_range = r.sensor.sensor_description.lower_range
      if upper_range != nil && r.value.to_f > upper_range
        problem_sensors << reading[:shortname]
      elsif lower_range != nil && r.value.to_f < lower_range
        problem_sensors << reading[:shortname]
      end
    end
    
    if problem_sensors.length > 0
      notification = Rpush::Gcm::Notification.new
      notification.app = Rpush::Gcm::App.find_by_name("Vehilytics")
      notification.registration_ids = [current_device.user.firebase_token]
      notification.data = { "title": "Problem Detected", "body": "#{current_device.device_name} has detected a possible issue" }
      notification.save!
      
      Rpush.push
    end
    
    result = {:time_reported => @report.time_reported, :readings => []}
    @report.readings.each do |r|
      result[:readings] << {:shortname => r.sensor.shortname, :value => r.value}
    end
    render json: result, status: :created
  end
  
  private
  
    def attach_sensor_to_device sensor, device
      if !device.sensors.include?(sensor)
        device.sensors << sensor
      end
    end
  
    def report_params
      params.permit(:time_reported)
    end
    
    def reading_params
      params.permit(:readings => [:shortname, :value])
    end
    
    def device_name
      params.permit(:device_name)
    end
  
end
