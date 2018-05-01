class V1::ReadingsController < ApplicationController
  
  def index
    if current_user == nil
      head(:unauthorized)
      return
    end
    
    if params.has_key?(:sensor)
      sensor = Sensor.find_by_shortname(params[:sensor])
    end
    
    retrieved_readings = []
    current_user.device.reports.each do |report|
      if params.has_key?(:sensor)
        retrieved_readings.concat(report.readings.where(sensor: sensor))
      else
        retrieved_readings.concat(report.readings)
      end
    end
    
    result = []
    retrieved_readings.each do |reading|
      result << {:sensor => reading.sensor.shortname, :value => reading.value, 
        :time_reported => reading.report.time_reported}
    end
    
    render json: {:readings => result}, status: :ok
  end
end
