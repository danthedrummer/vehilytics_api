class V1::ReadingsController < ApplicationController
  
  def index
    
  end
  
  private 
    
    def allow_params
      params.allow(:sensor_shortname)
    end
end
