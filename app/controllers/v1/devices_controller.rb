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
    
    if device_name != nil && params.has_key?('function')
      if params['function'] == 'attach'
        device  = Device.find_by_device_name(device_name)
        if device == nil
          render json: { "message": "Device does not exist" }, status: 400
          return
        else
          current_user.device = device
          render json: current_user.device.as_json(only: [:device_name, :email]), status: :created
          return
        end
      elsif params['function'] == 'detach'
        if current_user.device != nil && current_user.device.device_name == device_name
          current_user.device = nil
          current_user.save!
          head(200)
          return
        end
      end
    end
    
    head(400)
    return
    
  end
  
  # Detach a device from a user
  def destroy
    if current_user == nil
      head(:unauthorized)
      return
    end
    
    device_name = params[:device_name]
    
    if device_name == nil
      head(400)
      return
    end
    
    device = Device.find_by_device_name(device_name)
    
    if current_user.device != device
      head(400)
      return
    end
    
    current_user.device = nil
    head(200)
  end
  
end
