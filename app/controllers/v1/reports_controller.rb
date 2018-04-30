class V1::ReportsController < ApplicationController
  
  # GET all reports for current user
  # Intended for the client to use
  def index
    if current_user == nil
      head(:unauthorized)
      return 
    end
    
    @reports = current_user.device.reports
  end
  
  # Create a new report w/ readings for a given device
  # Intended for the diagnostic reader to use
  def create 
    
    if current_device == nil
      head(:unauthorized)
      return 
    end
    
    @report = Report.new(report_params)
    puts @report
    @report.device = current_device
    @report.save
    
    reading_params[:readings].each do |reading|
      r = Reading.new
      r.value = reading[:value]
      r.sensor = Sensor.find_by_shortname(reading[:shortname])
      r.report = @report
      r.save
    end
    
    result = {:time_reported => @report.time_reported, :readings => []}
    @report.readings.each do |r|
      result[:readings] << {:sensor => r.sensor.shortname, :value => r.value}
    end
    render json: result, status: :created
  end
  
  private
  
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
