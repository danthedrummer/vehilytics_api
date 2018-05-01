class V1::DevicesController < ApplicationController
  
  # Attach a device to a user
  def create
    if current_user == nil
      head(:unauthorized)
      return
    end
    
    device_name = params[:device_name]
    
    current_user.device = Device.find_by_device_name(device_name)
    
    render json: current_user.device.as_json(only: [:device_name, :email]), status: :created
  end
  
end
