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
    current_user.device.reports.reverse.each do |report|
      if sensor != nil
        retrieved_readings.concat(report.readings.where(sensor: sensor))
      else
        retrieved_readings.concat(report.readings)
      end
      if retrieved_readings.size == 100
        break
      end
    end
    
    result = []
    retrieved_readings.reverse.each do |reading|
      result << {:sensor => reading.sensor.shortname, :value => reading.value, 
        :time_reported => reading.report.time_reported}
    end
    
    if sensor != nil
      render json: {:readings => result, :info => sensor.sensor_description.info,
      :upper_range => sensor.sensor_description.upper_range, 
      :lower_range => sensor.sensor_description.lower_range}, status: :ok
    else
      render json: {:readings => result}, status: :ok
    end
  end
end
