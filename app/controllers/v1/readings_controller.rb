class V1::ReadingsController < ApplicationController
  
  def index
    if current_user == nil
      head(:unauthorized)
      return
    end
    
    @readings = []
    if params.has_key?(:sensor)
      current_user.device.reports.each do |report|
        report.readings.each do |reading|
          if reading.sensor.shortname == params[:sensor]
            @readings << {:sensor => reading.sensor.shortname, :value => reading.value, 
              :time_reported => reading.report.time_reported}
          end
        end
      end
    else
      current_user.device.reports.each do |report|
        report.readings.each do |reading|
          @readings << {:sensor => reading.sensor.shortname, :value => reading.value, 
            :time_reported => reading.report.time_reported}
        end
      end
    end
    result = {:readings => @readings}
    
    render json: result, status: :ok
  end
end
