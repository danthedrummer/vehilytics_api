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
    
    reading_params[:readings].each do |reading|
      r = Reading.new
      r.value = reading[:value]
      r.sensor = Sensor.find_by_shortname(reading[:shortname])
      attach_sensor_to_device(r.sensor, current_device)
      r.report = @report
      r.save
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
