class V1::DevicesController < ApplicationController
  
  def index
    if current_user == nil
      head(:unauthorized)
      return
    end
    
    if current_user.device != nil
      render json: current_user.device.as_json(only: [:device_name, :email]), status: :ok
    else
      render json: {:message => "No device attached to user"}, status: 400
    end
  end
  
  # Attach a device to a user
  def create
    if current_user == nil
      head(:unauthorized)
      return
    end
    
    device_name = params[:device_name]
    
    if device_name == nil
      head(400)
      return 
    end
    
    current_user.device = Device.find_by_device_name(device_name)
    
    render json: current_user.device.as_json(only: [:device_name, :email]), status: :created
  end
  
end
