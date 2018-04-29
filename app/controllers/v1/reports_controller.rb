class V1::ReportsController < ApplicationController
  
  def create 
    puts report_params
    @report = Report.new(report_params)
    puts @report
    @report.device = Device.find_by_device_name(params[:device_name])
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
    # render json: {:report => @report, :readings => { :sensor => @report.readings.sensor.shortname, :value => @report.readings } }, status: :created
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
