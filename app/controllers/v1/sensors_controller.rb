class V1::SensorsController < ApplicationController
  
  def index
    if current_user == nil
      head(:unauthorized)
      return
    end
    
    @sensors = Sensor.all
    render json: @sensors, status: :ok
  end
  
  def show
    if current_user == nil
      head(:unauthorized)
      return
    end
      
    @sensor = Sensor.find(params[:id])
    render json: @sensor, status: :ok
  end
  
end
