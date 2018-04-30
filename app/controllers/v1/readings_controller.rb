class V1::ReadingsController < ApplicationController
  
  def index
    if current_user == nil
      head(:unauthorized)
      return
    end
  end
  
  private 
    
    def allow_params
      params.allow(:sensor_shortname)
    end
end
